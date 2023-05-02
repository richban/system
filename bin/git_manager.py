"""
Git Manager CLI

A Python CLI app using Typer that combines the functionalities of finding all Git
repositories in the specified directory, generating a repos_list.txt file with their URLs,
and pulling or cloning them to another directory.

Usage:

1. To generate the repos_list.txt file based on the input path:
    python git_manager.py generate ~/Developer/projects

2. To pull repositories from the repos_list.txt file into the specified target directory (default is ~/Developer):
    python git_manager.py pull

3. To pull repositories into a different target directory:
    python git_manager.py pull ~/Custom/Target/Directory
"""

import os
import subprocess
from pathlib import Path

import typer

app = typer.Typer()


def get_remote_url(repo_dir: Path) -> str:
    try:
        remote_url = subprocess.check_output(
            ["git", "-C", str(repo_dir), "config", "--get", "remote.origin.url"],
            text=True,
        ).strip()
        return remote_url
    except subprocess.CalledProcessError:
        return ""


def find_git_repos(search_dir: Path) -> None:
    with open("repos_list.txt", "w") as output_file:
        for root, _, _ in os.walk(search_dir):
            git_dir = Path(root) / ".git"
            if git_dir.is_dir():
                remote_url = get_remote_url(git_dir.parent)
                if remote_url:
                    output_file.write(f"{remote_url}\n")
                    typer.echo(f"Found: {remote_url}")


@app.command()
def generate(input_path: Path):
    """Generate a repos_list.txt file containing Git repository URLs from the specified input path."""
    typer.echo("Generating repos_list.txt")
    find_git_repos(input_path)
    typer.echo("Generated repos_list.txt with Git repository URLs.")


@app.command()
def pull(target_dir: Path = Path.home() / "Developer"):
    """Pull or clone repositories from the repos_list.txt file to the specified target directory."""
    target_dir.mkdir(parents=True, exist_ok=True)
    typer.echo(f"Pulling repositories to {target_dir}")

    with open("repos_list.txt", "r") as input_file:
        for repo_url in input_file:
            repo_url = repo_url.strip()
            if not repo_url:
                continue

            repo_name = Path(repo_url.split("/")[-1]).stem
            repo_path = target_dir / repo_name

            if (repo_path / ".git").is_dir():
                typer.echo(f"Updating existing repository: {repo_name}")
                subprocess.run(["git", "-C", str(repo_path), "pull"])
            else:
                typer.echo(f"Cloning new repository: {repo_name}")
                subprocess.run(["git", "clone", repo_url, str(repo_path)])


if __name__ == "__main__":
    app()
