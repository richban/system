"""
Obsidian Backup CLI

A command-line application to backup and restore non-text attachments (PDF, PPTX, and Excel files) in an Obsidian vault.

Usage:

1. To backup attachments, run the following command:
   $ python obsidian_backup.py backup /path/to/your/obsidian/vault /path/to/your/backup/folder

2. To restore attachments, run the following command:
   $ python obsidian_backup.py restore /path/to/your/obsidian/vault /path/to/your/backup/folder

Note: Replace /path/to/your/obsidian/vault and /path/to/your/backup/folder with the correct paths to your Obsidian vault and backup folder.
"""

import os
import shutil
from zipfile import ZipFile

import typer

app = typer.Typer()

attachments = (".pdf", ".pptx", ".xlsx")


def backup_attachments(vault_path: str, backup_path: str):
    vault_path = os.path.abspath(vault_path)
    backup_path = os.path.abspath(backup_path)

    if not os.path.exists(backup_path):
        os.makedirs(backup_path)

    for foldername, subfolders, filenames in os.walk(vault_path):
        for filename in filenames:
            if filename.endswith(attachments):
                source = os.path.join(foldername, filename)
                destination = os.path.join(
                    backup_path, os.path.relpath(source, vault_path)
                )
                os.makedirs(os.path.dirname(destination), exist_ok=True)
                shutil.copy2(source, destination)

    backup_zip = os.path.join(backup_path, "vault_attachements_backup.zip")
    with ZipFile(backup_zip, "w") as zipf:
        for foldername, subfolders, filenames in os.walk(backup_path):
            if foldername != backup_path:
                for filename in filenames:
                    source = os.path.join(foldername, filename)
                    zipf.write(source, os.path.relpath(source, backup_path))


def restore_attachments(vault_path: str, backup_path: str):
    vault_path = os.path.abspath(vault_path)
    backup_path = os.path.abspath(backup_path)
    backup_zip = os.path.join(backup_path, "vault_attachments_backup.zip")

    with ZipFile(backup_zip, "r") as zipf:
        zipf.extractall(vault_path)


@app.command()
def backup(vault_path: str, backup_path: str):
    """
    Backup attachments from the Obsidian vault to a specified folder.
    """
    backup_attachments(vault_path, backup_path)
    typer.echo(f"Attachments backed up to {backup_path}/vault_attachements_backup.zip")


@app.command()
def restore(vault_path: str, backup_path: str):
    """
    Restore attachments from the backup folder to the Obsidian vault.
    """
    restore_attachments(vault_path, backup_path)
    typer.echo("Attachments restored to the Obsidian vault.")


if __name__ == "__main__":
    app()
