local iron = require('iron')

iron.core.add_repl_definitions {
  python = {
    venv_python = {
      command =  "pipenv run ipython"
    }
  }
}

iron.core.set_config {
  preferred = {
    python = "venv_python",
  }
}

