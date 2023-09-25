# Лекции

Код есть начиная с 3 лекции

**Запуск интерпретатора (VM)**

```
> erl
```

**Выход из интерпретатора**

```
[Gtrl-G]
> q
```

**Компиляция**

```
> erlc hello.erl # -> hello.beam
```

**Компиляция для отладки**

```
> erlc +debug_info hello.erl
```

**Запуск**

```
> erl -run hello hello_world -noshell -s init stop
```

**Запуск через интерпретатор (VM)**

```
> erl
1> c(hello).
2> hello:hello_world().
3> [Ctrl-G]
--> q
```

**Удаленная отладка в docker-контейнере для VS Code**

- Установить плагины

  - erlang
  - Remote Development

- Открыть работающий контейнер через "Remote Explorer"
- Установить в контейнере плагин "erlang"
- В качестве начального каталога установить **/home/student/src/**
- Скомпилировать программу с флагом "+debug_info"

```
> erlc +debug_info hello.erl
```

- Создать **launch.json**

```
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Launch erlang",
            "type": "erlang",
            "request": "launch",
            "cwd": "${workspaceRoot}",
            "arguments": "-s hello hello_world"
        }
    ]
}
```
