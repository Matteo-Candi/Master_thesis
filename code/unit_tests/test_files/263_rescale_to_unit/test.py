# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(numbers):
    min_num = min(numbers)
    max_num = max(numbers)
    result = []
    for n in numbers:
        result.append((n - min_num) / (max_num - min_num))
    return result

# End here


def serialize_list(obj) -> str:
    list_str = ["["]
    for item in obj:
        list_str.append(serialize_obj(item))
        list_str.append(",")
    list_str[-1] = "]"
    return "".join(list_str)


def serialize_dict(obj) -> str:
    m = OrderedDict(sorted(obj.items()))
    dict_str = ["{"]
    for key, value in m.items():
        dict_str.append(serialize_obj(key))
        dict_str.append(":")
        dict_str.append(serialize_obj(value))
        dict_str.append(",")
    dict_str[-1] = "}"
    return "".join(dict_str)


def serialize_obj(obj) -> str:
    if obj is None:
        return "null"
    if isinstance(obj, int) or isinstance(obj, float):
        return "{0:.6f}".format(obj)
    if isinstance(obj, str):
        return '"' + obj + '"'
    if isinstance(obj, bool):
        return str(obj)
    if isinstance(obj, list):
        return serialize_list(obj)
    if isinstance(obj, dict):
        return serialize_dict(obj)
    raise Exception("Unrecognized Type!")


def are_equivalent(o1, o2) -> bool:
    print(serialize_obj(o1)+" "+serialize_obj(o2))
    return serialize_obj(o1) == serialize_obj(o2)


def start():
    ret = False
    count = 0
    total = 0
    # Write the unit tests here
    total += 1
    ret = are_equivalent(testfunc([2.0,49.9]),[0.0,1.0])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([100.0,49.9]),[1.0,0.0])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([1.0,2.0,3.0,4.0,5.0]),[0.0,0.25,0.5,0.75,1.0])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([2.0,1.0,5.0,3.0,4.0]),[0.25,0.0,1.0,0.5,0.75])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([12.0,11.0,15.0,13.0,14.0]),[0.25,0.0,1.0,0.5,0.75])
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
