#!/bin/csh

set NAME = $(1420.5.6)

invert vis=$NAME map=$NAME.map beam=$NAME.beam robust=2 line=velocity slop=0.5

clean map=$NAME.map beam=$NAME.beam out=$NAME.clean

restor model=$NAME.clean beam=$NAME.beam map=$NAME.map out=$NAME_restored.map
