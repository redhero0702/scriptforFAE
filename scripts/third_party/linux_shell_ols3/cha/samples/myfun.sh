#! /bin/bash

myfun()
{
  local v
  echo "$FUNCNAME �����ܼ� v = $v"
  v=888
  echo "$FUNCNAME �����ܼ� v = $v"
}

v=999
myfun
echo "�D�{�������ܼ� v = $v"
