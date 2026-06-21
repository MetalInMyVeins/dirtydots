#!/bin/bash

if [ -f ".envrc" ]
then
  direnv allow .
fi

