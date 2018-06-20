""" Vim Filetype Plugin
" Language: csharp
" Summary: extend *.cs file config
" Version: 2018-06-19


setlocal textwidth=0
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab

command! -buffer FoldRegion :setlocal foldmarker=#region,#endregion | delcommand FoldRegion

abbreviate <buffer> gs; { get; set; }
abbreviate <buffer> using4; using System;
                           \using System.Collections;
                           \using System.Collections.Generic;
                           \using System.Linq;


" vim: set ts=3 sts=3 sw=3 et :
