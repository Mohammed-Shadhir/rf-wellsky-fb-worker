"""
    Config.py : contains methods to load yaml files and parse yamls as json
"""

import yaml


def initialize_selectors(fileName):
    return initialize_config(fileName)


def initialize_exceptions(fileName):
    return initialize_config(fileName)


def initialize_config(filename):
    stream = open(filename, "r")
    config_dict = yaml.safe_load(stream)
    return config_dict

