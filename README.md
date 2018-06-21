Dialyxir-pronto
============

[Pronto](https://github.com/mmozuras/pronto) runner for [dialyxir](https://github.com/jeremyjh/dialyxir)

Configuring runner
==================

First need install erlang-elixir-mix properly

Now you will need a global installation of [mix dialyxir](https://github.com/jeremyjh/dialyxir).

```
{:dialyxir, "~> 1.0.0-rc.2", runtime: false}
```

Installation
============

After install successfully dialyxir globally you simple need install this gem

```
gem install pronto-dialyxir
```

After the gem is installed, Pronto will already detect dialyxir runner inside a
elixir project.

Configure checkers
==================

You can configure in [mix.exs](https://github.com/jeremyjh/dialyxir#flags)

Credits
=======

- [pronto-credo](https://github.com/carakan/pronto-credo)
- [pronto-tailor](https://github.com/ajanauskas/pronto-tailor)
