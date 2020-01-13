#!/usr/bin/env python
import argparse
import os
import yaml

def inject(prefix, split="___", dot_rep="__"):
    def assign(env, conf, parts):
        assert len(parts) > 0, "Env var delimited parts must have at least 1 item"
        if len(parts) == 1:
            conf[parts[0]] = os.environ[env]
        else:
            part = parts[0]
            conf[part] = dict()
            assign(env, conf[part], parts[1:])


    envs = [env for env in os.environ if env.startswith(prefix)]
    conf = dict()

    for env in envs:
        stripped_env = env.replace(prefix, "", 1)
        parts = list(x.replace(dot_rep, ".")
            for x in filter(None, stripped_env.split(split)))

        if len(parts) > 0:
            assign(env, conf, parts)

    return conf


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Inject env var as yaml.')
    parser.add_argument(
        'prefix',
        help='env var prefix to capture')
    args = parser.parse_args()
    print(yaml.dump(inject(args.prefix)))
