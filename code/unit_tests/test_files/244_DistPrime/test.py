# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(arr, allPrimes):
    list1 = []
    for i in allPrimes:
        for j in arr:
            if j % i == 0:
                list1.append(i)
                break
    return list1
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
    ret = are_equivalent(testfunc([4,6,8,10],[2,3,5,7]),[2,3,5])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([9,15,21,25],[2,3,5,7]),[3,5,7])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([11,13,17,19],[2,3,5,7,11,13,17,19]),[11,13,17,19])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([27,33,15],[9,11,5]),[9,11,5])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([27,33,15],[17,19,5]),[5])
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
