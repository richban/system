"""
    The script will recursively search for .envrc files in the ~/Developer folder and
    its subdirectories and copy them to the specified backup directory, preserving
    the directory structure.

    python backup_envrc.py backup_envrc --backup-dir <backup_directory_path>
    python backup_envrc.py sync_envrc --source-dir <source_directory_path>
"""
import os
import shutil
from typing import List

import typer

app = typer.Typer()


def backup_envrc_files(source_dir: str, backup_dir: str) -> None:
    """
    Recursively backup .envrc files from the source directory to the backup directory.

    Args:
        source_dir (str): The source directory to search for .envrc files.
        backup_dir (str): The backup directory where the .envrc files will be copied.
    """
    envrc_files = []
    for root, dirs, files in os.walk(source_dir):
        for file in files:
            if file == ".envrc":
                envrc_files.append(os.path.join(root, file))

    for envrc_file in envrc_files:
        # Get the relative path of the file to preserve the directory structure
        rel_path = os.path.relpath(envrc_file, source_dir)
        # Construct the destination path in the backup directory
        dest_path = os.path.join(backup_dir, rel_path)

        # Create the parent directories if they don't exist in the backup directory
        os.makedirs(os.path.dirname(dest_path), exist_ok=True)
        # Copy the .envrc file to the backup directory
        shutil.copy2(envrc_file, dest_path)


def sync_envrc_files(source_dir: str, backup_dir: str) -> None:
    """
    Sync .envrc files from the backup directory back to their original source destinations.

    Args:
        source_dir (str): The source directory where .envrc files were originally located.
        backup_dir (str): The backup directory where the .envrc files were backed up.
    """
    envrc_files = []
    for root, dirs, files in os.walk(backup_dir):
        for file in files:
            if file == ".envrc":
                envrc_files.append(os.path.join(root, file))

    for envrc_file in envrc_files:
        # Get the relative path of the file to preserve the directory structure
        rel_path = os.path.relpath(envrc_file, backup_dir)
        # Construct the destination path in the source directory
        dest_path = os.path.join(source_dir, rel_path)

        # Create the parent directories if they don't exist in the source directory
        os.makedirs(os.path.dirname(dest_path), exist_ok=True)

        if os.path.exists(dest_path):
            # File already exists in the destination, prompt user for confirmation
            overwrite = typer.confirm(
                f"The file '{os.path.basename(dest_path)}' already exists in the destination. Overwrite it?"
            )
            if not overwrite:
                continue

        # Copy the .envrc file from the backup directory back to the source directory
        shutil.copy2(envrc_file, dest_path)


@app.command()
def backup_envrc(
    backup_dir: str = typer.Option(
        "~/envrc_backup", "--backup-dir", "-b", help="Backup directory path"
    )
):
    """
    Recursively backup .envrc files from the default folder ~/Developer to the specified backup directory.

    Args:
        backup_dir (str): The backup directory where the .envrc files will be copied.
    """
    source_dir = os.path.expanduser("~/Developer")

    typer.echo(f"Backing up .envrc files from {source_dir} to {backup_dir}...")

    try:
        backup_envrc_files(source_dir, backup_dir)
        typer.echo("Backup completed successfully.")
    except Exception as e:
        typer.echo(f"An error occurred during backup: {str(e)}")


@app.command()
def sync_envrc(
    source_dir: str = typer.Option(
        "~/Developer", "--source-dir", "-s", help="Source directory path"
    )
):
    """
    Sync .envrc files from the backup directory back to their original source destinations.

    Args:
        source_dir (str): The source directory where .envrc files were originally located.
    """
    backup_dir = os.path.expanduser("~/envrc_backup")

    typer.echo(f"Syncing .envrc files from {backup_dir} back to {source_dir}...")

    try:
        sync_envrc_files(source_dir, backup_dir)
        typer.echo("Sync completed successfully.")
    except Exception as e:
        typer.echo(f"An error occurred during sync: {str(e)}")


if __name__ == "__main__":
    app()
