""" Theme: record of your journey
""" Summary: 冒険の書を記録しますか?
""" Version: 2018-06-20


if exists('g:loaded_recordjourney')
   finish
endif
let g:loaded_recordjourney = 1

let s:record = {}
let s:record.lang = split(&helplang, ',')[0]
if s:record.lang == 'ja'
   let s:record.confirm = 'ぼうけんのしょをきろくしますか？'
   let s:record.success = 'ぼうけんのしょをきろくしました'
   let s:record.fail = 'ぼうけんのしょをきろくできませんでした'
elseif s:record.lang == 'en'
   let s:record.confirm = 'Will you record your journey?'
   let s:record.success = 'Recorded your journey!'
   let s:record.fail = 'The record of the journey was lost!'
else
   " error:
   finish
endif

command! RecordJourney :call <SID>RecordJourney()
function! s:RecordJourney()
   echo ''
   let bufline = &l:statusline
   call s:RecordJourneyMessage(s:record.confirm)
   let &l:statusline .= ' (y/n)'
   redraw
   sleep 100ms
   let c = nr2char(getchar())
   if c == 'y'
      let message = s:record.success
      try
         silent w
      catch /.*/
         let message = s:record.fail
      endtry
      call s:RecordJourneyMessage(message)
      let &l:statusline .= ' *'
      redraw
      sleep 100ms
      call getchar()
   endif
   let &l:statusline = bufline
   redraw
endfunction

function! s:RecordJourneyMessage(message)
   let &l:statusline = ''
   for m in split(a:message, '\zs')
      let &l:statusline .= m
      redraw
      sleep 100ms
   endfor
endfunction


" vim: set ts=3 sts=3 sw=3 et :
