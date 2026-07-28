#!/usr/bin/env python3
"""
Pack .kicad_symdir directories into single .kicad_sym files.

Each .kicad_symdir contains individual .kicad_sym files with one symbol each.
This script combines them into a single .kicad_sym file per library by:
  1. Writing a shared header (version, generator, generator_version)
  2. Extracting (symbol ...) nodes from each individual file
  3. Closing the library
"""

import argparse
import os
import re
import sys


def depth_change(line):
    """Return net parenthesis depth change, ignoring content inside double quotes."""
    depth = 0
    in_string = False
    escaped = False

    for ch in line:
        if escaped:
            escaped = False
            continue

        if ch == '\\':
            escaped = True
            continue

        if ch == '"':
            in_string = not in_string
            continue

        if not in_string:
            if ch == '(':
                depth += 1
            elif ch == ')':
                depth -= 1

    return depth


def extract_header(filepath):
    """Extract version, generator, and generator_version from a .kicad_sym file."""
    with open(filepath, 'r') as f:
        content = f.read()

    version = re.search(r'\(version\s+(\S+)\)', content)
    generator = re.search(r'\(generator\s+"([^"]+)"\)', content)
    gen_version = re.search(r'\(generator_version\s+"([^"]+)"\)', content)

    return {
        'version': version.group(1) if version else '20251024',
        'generator': generator.group(1) if generator else 'kicad_symbol_editor',
        'generator_version': gen_version.group(1) if gen_version else '9.99',
    }


def extract_symbols(filepath):
    """Extract all (symbol ...) blocks from a .kicad_sym file.

    Returns a list of strings, each being a complete (symbol ...) block
    with its original indentation preserved.
    """
    with open(filepath, 'r') as f:
        lines = f.readlines()

    symbols = []
    current_block = []
    block_depth = 0
    in_block = False

    for line in lines:
        if not in_block:
            if re.match(r'\t\(symbol\s', line):
                in_block = True
                block_depth = depth_change(line)
                current_block = [line]
        else:
            current_block.append(line)
            block_depth += depth_change(line)

            if block_depth <= 0:
                symbols.append(''.join(current_block))
                current_block = []
                in_block = False

    return symbols


def pack_library(symdir_path, output_path):
    """Pack a .kicad_symdir directory into a single .kicad_sym file."""
    sym_files = sorted(
        f for f in os.listdir(symdir_path) if f.endswith('.kicad_sym')
    )

    if not sym_files:
        print(f"  Warning: {symdir_path} contains no .kicad_sym files, skipping", file=sys.stderr)
        return False

    header = extract_header(os.path.join(symdir_path, sym_files[0]))

    with open(output_path, 'w') as out:
        out.write('(kicad_symbol_lib\n')
        out.write(f'\t(version {header["version"]})\n')
        out.write(f'\t(generator "{header["generator"]}")\n')
        out.write(f'\t(generator_version "{header["generator_version"]}")\n')

        for sym_file in sym_files:
            filepath = os.path.join(symdir_path, sym_file)
            symbols = extract_symbols(filepath)

            if not symbols:
                print(f"  Warning: no symbol blocks found in {filepath}", file=sys.stderr)
                continue

            for symbol in symbols:
                out.write(symbol)

        out.write(')\n')

    return True


def main():
    parser = argparse.ArgumentParser(description='Pack .kicad_symdir directories into .kicad_sym files')
    parser.add_argument(
        'source_dir', nargs='?', default='.',
        help='Directory containing .kicad_symdir directories (default: current directory)'
    )
    parser.add_argument(
        '--output-dir', default=None,
        help='Output directory for packed .kicad_sym files (default: same as source_dir)'
    )
    args = parser.parse_args()

    source_dir = os.path.abspath(args.source_dir)
    output_dir = os.path.abspath(args.output_dir) if args.output_dir else source_dir

    if args.output_dir:
        os.makedirs(output_dir, exist_ok=True)

    symdirs = sorted(
        d for d in os.listdir(source_dir)
        if d.endswith('.kicad_symdir') and os.path.isdir(os.path.join(source_dir, d))
    )

    if not symdirs:
        print(f"No .kicad_symdir directories found in {source_dir}", file=sys.stderr)
        sys.exit(1)

    print(f"Packing {len(symdirs)} libraries...")
    packed = 0

    for symdir in symdirs:
        lib_name = symdir.replace('.kicad_symdir', '.kicad_sym')
        symdir_path = os.path.join(source_dir, symdir)
        output_path = os.path.join(output_dir, lib_name)

        if pack_library(symdir_path, output_path):
            packed += 1

    print(f"Packed {packed} libraries into {output_dir}")


if __name__ == '__main__':
    main()
