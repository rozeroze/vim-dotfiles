""" Vim plugin script
""" Summary: dungeon keeper on Vim
""" Authors: rozeroze <rosettastone1886@gmail.com>
""" Version: 2018-07-30


""" documents
" rule of positions {{{
" buffer-window左上は { 'posx': 1, 'posy': 1 } として扱う
"    +---- example -----
"    |a      c
"    |   b
"    |
" 上記の各a,b,cはそれぞれ以下になる
"    a: { 'posx': 1, 'posy': 1 }
"    b: { 'posx': 4, 'posy': 2 }
"    c: { 'posx': 8, 'posy': 1 }
" }}}

""" variables
" let s:dungeon {{{
let s:dungeon = {}
let s:dungeon['bufnr'] = 0
let s:dungeon['posx'] = 0
let s:dungeon['posy'] = 0
let s:dungeon['vertical'] = 0
let s:dungeon['horizontal'] = 0
let s:dungeon['path'] = expand('<sfile>:p:h')
" }}}
" let s:master {{{
let s:master = {}
let s:master['list'] = []
function! s:master.add(unit) dict
   call add(self['list'], a:unit)
endfunction
function! s:master.remove(unit) dict
   call s:message.print(printf('call s:master.remove(%s)', a:unit['name']))
   let idx = self.getindex(a:unit)
   call remove(self['list'], idx)
endfunction
function! s:master.exists(x, y) dict
   let _list = deepcopy(self['list'])
   call filter(_list, printf('v:val["posx"] == %s && v:val["posy"] == %s', a:x, a:y))
   if len(_list)
      return _list[0]
   else
      return v:false
   endif
endfunction
function! s:master.getindex(unit) dict
   let idx = index(self['list'], a:unit)
   return idx
endfunction
function! s:master.next() dict
   if len(self['list']) > 1
      let first = self['list'][0]
      call remove(self['list'], 0)
      call self['add'](first)
   endif
endfunction
function! s:master.action() dict
   let unit = self['list'][0]
   if unit['name'] == 'keeper'
      return unit['action']()
   else
      call unit['action']()
      return v:true
   endif
endfunction
" }}}
" let s:message {{{
let s:message = {}
let s:message['list'] = []
function! s:message.print(mes) dict
   "echo a:mes
   call add(self['list'], a:mes)
endfunction
function! s:message.history() dict
   vnew
   setlocal bufhidden=delete buftype=nofile
   call append(line('$'), '====== message history ======')
   for mes in self['list']
      call append(line('$'), mes)
   endfor
endfunction
" }}}
" let s:plain {{{
let s:plain = {}
let s:plain['icon'] = '.'
let s:plain['name'] = 'plain'
let s:plain['side'] = 'none'
function! s:plain.isplain(x, y)
   " xとyを与え、その場所がplainかどうかを真偽値で返す
   let cell = getline(a:y)[a:x-1]
   return (cell == '.')
endfunction
function! s:plain.getplain()
   " plainな場所をランダムで選択し、[posx, posy]を返す
   let lastline = line('$')
   while v:true
      let y = dungeon#random(lastline) + 1
      let line = getline(y)
      let dotcount = count(split(line, '\zs'), '.')
      if dotcount
         let x = match(line, '\.', 0, dungeon#random(dotcount)) + 1
         if s:plain.isplain(x, y)
            return [x, y]
         endif
      endif
   endwhile
endfunction
function! s:plain.getadjacent()
   " plainに隣接する場所をランダムで選択し、[posx, posy]を返す
endfunction
function! s:plain.replace(x, y, icon)
   let line = getline(a:y)
   let line = line[: a:x-2] . a:icon . line[a:x :]
   call setline(a:y, line)
endfunction
" }}}
" let s:wall {{{
let s:wall = {}
let s:wall['icon'] = ' '
let s:wall['name'] = 'wall'
let s:wall['type'] = 'none'
" }}}
" let s:unit {{{
let s:unit = {}
function! s:unit.move(x, y) dict
   if s:plain.isplain(a:x, a:y)
      call s:message.print(printf('success unit.move(%s)', self['name']))
      call s:plain.replace(self['posx'], self['posy'], s:plain['icon'])
      let self['posx'] = a:x
      let self['posy'] = a:y
      call s:plain.replace(self['posx'], self['posy'], self['icon'])
   endif
endfunction
function! s:unit.move_random() dict
   let rand = dungeon#random(4)
   if rand == 0
      call call(s:unit['move_left'], [], self)
   elseif rand == 1
      call call(s:unit['move_down'], [], self)
   elseif rand == 2
      call call(s:unit['move_up'], [], self)
   elseif rand == 3
      call call(s:unit['move_right'], [], self)
   endif
endfunction
function! s:unit.move_left() dict
   if s:plain.isplain(self['posx'] - 1, self['posy'])
      call s:message.print(printf('success unit.move_left(%s)', self['name']))
      call s:plain.replace(self['posx'], self['posy'], s:plain['icon'])
      let self['posx'] -= 1
      call s:plain.replace(self['posx'], self['posy'], self['icon'])
   endif
endfunction
function! s:unit.move_down() dict
   if s:plain.isplain(self['posx'], self['posy'] + 1)
      call s:message.print(printf('success unit.move_dowm(%s)', self['name']))
      call s:plain.replace(self['posx'], self['posy'], s:plain['icon'])
      let self['posy'] += 1
      call s:plain.replace(self['posx'], self['posy'], self['icon'])
   endif
endfunction
function! s:unit.move_up() dict
   if s:plain.isplain(self['posx'], self['posy'] - 1)
      call s:message.print(printf('success unit.move_up(%s)', self['name']))
      call s:plain.replace(self['posx'], self['posy'], s:plain['icon'])
      let self['posy'] -= 1
      call s:plain.replace(self['posx'], self['posy'], self['icon'])
   endif
endfunction
function! s:unit.move_right() dict
   if s:plain.isplain(self['posx'] + 1, self['posy'])
      call s:message.print(printf('success unit.move_right(%s)', self['name']))
      call s:plain.replace(self['posx'], self['posy'], s:plain['icon'])
      let self['posx'] += 1
      call s:plain.replace(self['posx'], self['posy'], self['icon'])
   endif
endfunction
function! s:unit.damage(...) dict
   call s:message.print(printf('call s:unit.damage(%s)', self['name']))
   if a:0 == 0
      let self['life'] -= (dungeon#random() + 1)
   else
      let self['life'] -= a:1
   endif
   if self['life'] <= 0
      call s:message.print(printf('  unit was died, who name is %s', self['name']))
      call s:master.remove(self)
      call s:plain.replace(self['posx'], self['posy'], s:plain['icon'])
   endif
endfunction
function! s:unit.cure(...) dict
   call s:message.print(printf('call s:unit.cure(%s)', self['name']))
   if a:0 == 0
      let self['life'] += (dungeon#random() + 1)
   else
      let self['life'] += a:1
   endif
endfunction
" }}}
" let s:keeper {{{
let s:keeper = {}
let s:keeper['icon'] = '#'
let s:keeper['name'] = 'keeper'
let s:keeper['side'] = 'monster'
let s:keeper['posx'] = 0
let s:keeper['posy'] = 0
let s:keeper['life'] = 0
let s:keeper['mana'] = 0
let s:keeper['hate'] = 0
function! s:keeper.action() dict
   let command = nr2char(getchar())
   if command == 'q' || command == ''
      return v:false
   endif
   call self['action_' . command]()
   return v:true
endfunction
function! s:keeper.action_h() dict
   call call(s:unit['move_left'], [], self)
endfunction
function! s:keeper.action_j() dict
   call call(s:unit['move_down'], [], self)
endfunction
function! s:keeper.action_k() dict
   call call(s:unit['move_up'], [], self)
endfunction
function! s:keeper.action_l() dict
   call call(s:unit['move_right'], [], self)
endfunction
function! s:keeper.action_s() dict
   " summon
   let cross = call(s:action.get_cross, [], self)
   let cross = cross['plain']
   if len(cross) == 0
      call s:message.print('not found plain around keeper')
      return
   endif
   let plain = cross[dungeon#random(len(cross))]
   let name = input('monster name: ', '', 'customlist,dungeon#monsterlist')
   if has_key(s:monsters['dict'], name)
      let monster = deepcopy(s:monsters['dict'][name])
      if self['mana'] >= monster['mana']
         let self['mana'] -= monster['mana']
         let monster['posx'] = plain['posx']
         let monster['posy'] = plain['posy']
         call dungeon#create(monster)
      endif
   endif
endfunction
function! s:keeper.action_w() dict
   let self['mana'] += 1
endfunction
function! s:keeper.action_d() dict
   " TODO: test
   call dungeon#debug()
   sleep 2000ms
endfunction
function! s:keeper.action_m() dict
   call s:message.history()
   sleep 2000ms
endfunction
" }}}
" let s:gate {{{
let s:gate = {}
let s:gate['icon'] = '%'
let s:gate['name'] = 'gate'
let s:gate['side'] = 'brave'
let s:gate['posx'] = 0
let s:gate['posy'] = 0
let s:gate['life'] = 0
let s:gate['mana'] = 0
let s:gate['hate'] = 0
function! s:gate.action() dict
   call s:message.print('gate.action()')
   let self['mana'] += 1
   if self['mana'] < 8
      return
   endif
   let cross = call(s:action.get_cross, [], self)
   let cross = cross['plain']
   if len(cross) == 0
      return
   endif
   let plain = cross[dungeon#random(len(cross))]
   if dungeon#random(3) == 0
      " summon
      let idx = dungeon#random(len(s:braves['list']))
      let name = s:braves['list'][idx]
      let brave = deepcopy(s:braves['dict'][name])
      if self['mana'] >= brave['mana']
         let self['mana'] -= brave['mana']
         let brave['posx'] = plain['posx']
         let brave['posy'] = plain['posy']
         call dungeon#create(brave)
      endif
   endif
endfunction
" }}}

""" action
" let s:action {{{
let s:action = {}
function! s:action.get_cross() dict
   let _cross = {}
   let _cross['list'] = []
   call add( _cross['list'], dungeon#getobj(self['posx']    , self['posy'] - 1) )
   call add( _cross['list'], dungeon#getobj(self['posx']    , self['posy'] + 1) )
   call add( _cross['list'], dungeon#getobj(self['posx'] - 1, self['posy']    ) )
   call add( _cross['list'], dungeon#getobj(self['posx'] + 1, self['posy']    ) )
   let _cross['brave']   = filter(deepcopy(_cross['list']), 'v:val["side"] == "brave"')
   let _cross['monster'] = filter(deepcopy(_cross['list']), 'v:val["side"] == "monster"')
   let _cross['plain']   = filter(deepcopy(_cross['list']), 'v:val["name"] == "plain"')
   let _cross['wall']    = filter(deepcopy(_cross['list']), 'v:val["name"] == "wall"')
   return _cross
endfunction
function! s:action.attack_brave() dict
   " summary: 近くのbraveを無作為に攻撃
   let cross = call(s:action.get_cross, [], self)
   let cross = cross['brave']
   if len(cross) != 0
      let target = cross[dungeon#random(len(cross))]
      let index = s:master.getindex(target)
      call call(s:unit['damage'], [], s:master['list'][index])
      return v:true
   endif
   return v:false
endfunction
function! s:action.attack_monster() dict
   " summary: 近くのbraveを無作為に攻撃
   let cross = call(s:action.get_cross, [], self)
   let cross = cross['monster']
   if len(cross) != 0
      let target = cross[dungeon#random(len(cross))]
      let index = s:master.getindex(target)
      call call(s:unit['damage'], [], s:master['list'][index])
      return v:true
   endif
   return v:false
endfunction
function! s:action.attack_brave_highhate() dict
   " summary: hateを最も稼いでいるbraveを攻撃
   let cross = call(s:action.get_cross, [], self)
   let cross = cross['brave']
   if len(cross) != 0
      let _hate = max(map(deepcopy(cross), 'v:val["hate"]' ))
      call filter(cross, printf('v:val["hate"] == %s', _hate))
      let target = cross[dungeon#random(len(cross))]
      let index = s:master.getindex(target)
      call call(s:unit['damage'], [], s:master['list'][index])
      return v:true
   endif
   return v:false
endfunction
function! s:action.attack_monster_highhate() dict
   " summary: hateを最も稼いでいるmonsterを攻撃
   let cross = call(s:action.get_cross, [], self)
   let cross = cross['monster']
   if len(cross) != 0
      let _hate = max(map(deepcopy(cross), 'v:val["hate"]' ))
      call filter(cross, printf('v:val["hate"] == %s', _hate))
      let target = cross[dungeon#random(len(cross))]
      let index = s:master.getindex(target)
      call call(s:unit['damage'], [], s:master['list'][index])
      return v:true
   endif
   return v:false
endfunction
function! s:action.move_access(unit) dict
   let actions = []
   let x = a:unit['posx'] - self['posx']
   let y = a:unit['posy'] - self['posy']
   if x > 0
      call add(actions, 'move_right')
   elseif x < 0
      call add(actions, 'move_left')
   endif
   if y > 0
      call add(actions, 'move_down')
   elseif y < 0
      call add(actions, 'move_up')
   endif
   let action = actions[dungeon#random(len(actions))]
   call call(s:unit[action], [], self)
endfunction
function! s:action.move_enemy() dict
   let enemy = deepcopy(s:master['list'])
   if self['side'] == 'brave'
      call filter(enemy, 'v:val["side"] == "monster"')
   else
      call filter(enemy, 'v:val["side"] == "brave"')
   endif
   let _distance = min(map(deepcopy(enemy), printf('abs(v:val["posx"] - %s) + abs(v:val["posy"] - %s)', self['posx'], self['posy'])))
   if _distance < 2
      return
   endif
   call filter(enemy, printf('abs(v:val["posx"] - %s) + abs(v:val["posy"] - %s) == %s', self['posx'], self['posy'], _distance))
   let enemy = enemy[dungeon#random(len(enemy))]
   call call(s:action.move_access, [enemy], self)
endfunction
function! s:action.move_friend() dict
   let friend = deepcopy(s:master['list'])
   if self['side'] == 'brave'
      call filter(friend, 'v:val["side"] == "brave"')
   else
      call filter(friend, 'v:val["side"] == "monster"')
   endif
   let _distance = map(deepcopy(friend), printf('abs(v:val["posx"] - %s) + abs(v:val["posy"] - %s)', self['posx'], self['posy']))
   let _distance = get(sort(_distance, 'n'), 1)
   if _distance < 2
      return
   endif
   call filter(friend, printf('abs(v:val["posx"] - %s) + abs(v:val["posy"] - %s) == %s', self['posx'], self['posy'], _distance))
   let friend = friend[dungeon#random(len(friend))]
   call call(s:action.move_access, [friend], self)
endfunction
function! s:action.confusion() dict
   " summary: 四方をrandomに選び、plainなら移動、壁は何もせず、他なら攻撃
   let cross = call(s:action.get_cross, [], self)
   let cross = cross['list']
   let target = cross[dungeon#random(len(cross))]
   if target['name'] == 'plain'
      " 移動
      call call(s:unit['move'], [target['posx'], target['posy']], self)
   elseif target['name'] == 'wall'
      " 壁なら何もしない
   else
      " 殴る
      let index = s:master.getindex(target)
      call call(s:unit['damage'], [], s:master['list'][index])
   endif
endfunction
function! s:action.berserker() dict
   " summary: 周りに何もなければ移動、
   "          あれば、とにかく殴る
   let cross = call(s:action.get_cross, [], self)
   if len(cross['plain']) == 4
      call call(s:unit['move_random'], [], self)
   else
      let cross = cross['list']
      call filter(cross, 'v:val["name"] != "plain"')
      let target = cross[dungeon#random(len(cross))]
      if target['name'] == 'wall'
         call call(s:unit['damage'], [], self)
      else
         let index = s:master.getindex(target)
         call call(s:unit['damage'], [], s:master['list'][index])
      endif
   endif
endfunction
function! s:action.charm() dict
   " summary: 自サイドのユニットを攻撃する
   "          近くに自サイドがいなければ移動
   let cross = call(s:action.get_cross, [], self)
   let own = self['side']
   if len(cross[own]) != 0
      if own == 'brave'
         call call(s:action.attack_brave, [], self)
      elseif own == 'monster'
         call call(s:action.attack_monster, [], self)
      endif
   else
      call call(s:action.move_friend, [], self)
   endif
endfunction
" }}}
" function s:action.{monster}() {{{
function! s:action.bat() dict
   " priority: attack
   " move: random
   " attack: 近くの敵を無作為に攻撃
   " skill: 吸血(cure) まれに発動
   call s:message.print('bat turn')
   if call(s:action.attack_brave, [], self)
      if dungeon#random(7) == 0 && self['life'] < 4
         call call(s:unit['cure'], [], self)
      endif
   else
      call call(s:unit['move_random'], [], self)
   endif
endfunction
function! s:action.slime() dict
   " priority: attack
   " move: 時々randomに動く
   " attack: 近くの敵を無作為に攻撃
   " skill: 分裂
   call s:message.print('slime turn')
   if call(s:action.attack_brave, [], self)
      " no action
   else
      if dungeon#random(3) == 0
         call call(s:unit['move_random'], [], self)
      elseif dungeon#random(5) == 0
         let self['mana'] += dungeon#random()
      elseif dungeon#random(7) == 0
         " skill 分裂
         let plain = call(s:action.get_cross, [], self)['plain']
         if len(plain) != 0
            let plain = plain[dungeon#random(len(plain))]
            let self['mana'] = self['mana'] / 2
            let division = deepcopy(self)
            let division['posx'] = plain['posx']
            let division['posy'] = plain['posy']
            call s:message.print('slime divisioning by skill')
            call dungeon#create(division)
         endif
      endif
   endif
endfunction
function! s:action.goblin() dict
   " priority: 仲間が近くにいれば攻撃、いなければ仲間の近くに移動
   " move: 仲間の近くに
   " attack: hateが高い敵
   " skill: none
   call s:message.print('goblin turn')
   let cross = call(s:action.get_cross, [], self)
   let braves = cross['brave']
   let keepers = cross['monster']
   if len(keepers) > 0
      " 近くに仲間がいる
      if call(s:action.attack_brave_highhate, [], self)
         " no action
      else
         let self['hate'] += dungeon#random(2)
      endif
   else
      " 近くに仲間がいない
      call call(s:action.move_friend, [], self)
   endif
endfunction
function! s:action.gengar() dict
   " priority: none
   " move: 基本動かない、近くに誰かがいると、いない方向に移動
   " attack: near-enemy
   " skill: 自身のhate値が下がる
   call s:message.print('gengar turn')
   let cross = call(s:action.get_cross, [], self)
   let brave = cross['brave']
   let monster = cross['monster']
   if len(brave) != 0 || len(monster) != 0
      if dungeon#random(3) == 0
         if len(brave) != 0
            " skill 影操り
            let brave = brave[dungeon#random(len(brave))]
            if brave['name'] != 'gate'
               let index = s:master.getindex(brave)
               let s:master['list'][index]['action'] = s:action.charm
            endif
         endif
      else
         call call(s:unit['move_random'], [], self)
      endif
   else
      if self['hate'] > 0
         let self['hate'] -= 1
      endif
   endif
endfunction
function! s:action.skeleton() dict
   " priority: attack
   " move: near-enemy
   " attack: near-enemy
   " skill: 敵を倒したとき、自身のmanaを消費し死体をskeletonにする
   call s:message.print('skeleton turn')
   if call(s:action.attack_brave, [], self)
   else
   endif
endfunction
function! s:action.element() dict
   " priority: escape, cure me, cure friend
   " move: 基本動かない、近くに敵がいると逃げる
   " attack: 攻撃しない、自身か仲間をcure
   " skill: 回復(mana1を消費) まれにmanaを回復
   call s:message.print('element turn')
endfunction
function! s:action.armor() dict
   " priority: attack
   " move: near-enemy
   " attack: high hate
   " skill: none
   call s:message.print('armor turn')
endfunction
function! s:action.harpy() dict
   " priority: attack
   " move: 近くの仲間のところに移動
   " attack: high hate
   " skill: 魅了
   call s:message.print('harpy turn')
endfunction
function! s:action.fiary() dict
   " priority: escape
   " move: 時々randomに動く
   " attack: 攻撃するか、技能をつかう
   " skill: 対象を状態異常(混乱)にする changeling
   call s:message.print('fiary turn')
endfunction
function! s:action.witch() dict
   " priority: manaの状態による
   " move: 近くに敵がいる(mana有攻撃、mana無逃げる)
   "       敵がいない(mana有random移動、mana無移動せずmana回復)
   " attack: manaを消費し技能を使う
   " skill: 対象を状態異常(狂化)にする
   call s:message.print('witch turn')
endfunction
" }}}
" function s:action.{brave}() {{{
function! s:action.fighter() dict
   " priority: attack
   " move: near-enemy
   " attack: 近くの敵を無作為に攻撃
   " skill: none
   call s:message.print('fighter turn')
   return
   if !call(s:action.attack_monster, [], self)
      call call(s:action.move_enemy, [], self)
   endif
endfunction
function! s:action.sword() dict
   call s:message.print('sword turn')
   return
   if !call(s:action.attack_monster, [], self)
      call call(s:action.move_enemy, [], self)
   endif
endfunction
function! s:action.bishop() dict
   call s:message.print('bishop turn')
   return
   if !call(s:action.attack_monster, [], self)
      call call(s:action.move_enemy, [], self)
   endif
endfunction
function! s:action.kid() dict
   call s:message.print('kid turn')
   return
   if !call(s:action.attack_monster, [], self)
      call call(s:action.move_enemy, [], self)
   endif
endfunction
function! s:action.lancer() dict
   call s:message.print('lancer turn')
   return
   if !call(s:action.attack_monster, [], self)
      call call(s:action.move_enemy, [], self)
   endif
endfunction
function! s:action.tamer() dict
   call s:message.print('tamer turn')
   return
   if !call(s:action.attack_monster, [], self)
      call call(s:action.move_enemy, [], self)
   endif
endfunction
function! s:action.rook() dict
   call s:message.print('rook turn')
   return
   if !call(s:action.attack_monster, [], self)
      call call(s:action.move_enemy, [], self)
   endif
endfunction
function! s:action.assassin() dict
   call s:message.print('assassin turn')
   return
   if !call(s:action.attack_monster, [], self)
      call call(s:action.move_enemy, [], self)
   endif
endfunction
function! s:action.wizard() dict
   call s:message.print('wizard turn')
   return
   if !call(s:action.attack_monster, [], self)
      call call(s:action.move_enemy, [], self)
   endif
endfunction
function! s:action.magician() dict
   call s:message.print('magician turn')
   return
   if !call(s:action.attack_monster, [], self)
      call call(s:action.move_enemy, [], self)
   endif
endfunction
function! s:action.criminal() dict
   call s:message.print('criminal turn')
   return
   if !call(s:action.attack_monster, [], self)
      call call(s:action.move_enemy, [], self)
   endif
endfunction
" }}}

""" monsters & braves
" let s:monsters {{{
let s:monsters = {}
let s:monsters['list'] = [ 'bat', 'slime', 'goblin', 'gengar', 'skeleton', 'element', 'armor', 'harpy', 'fiary', 'witch' ]
let s:monsters['dict'] = {
         \ 'bat':      { 'icon': '^', 'name': 'bat',      'side': 'monster', 'life': 2, 'mana': 2, 'hate': 1, 'action': s:action.bat },
         \ 'slime':    { 'icon': '3', 'name': 'slime',    'side': 'monster', 'life': 2, 'mana': 3, 'hate': 0, 'action': s:action.slime },
         \ 'goblin':   { 'icon': '@', 'name': 'goblin',   'side': 'monster', 'life': 3, 'mana': 3, 'hate': 2, 'action': s:action.goblin },
         \ 'gengar':   { 'icon': '&', 'name': 'gengar',   'side': 'monster', 'life': 4, 'mana': 7, 'hate': 0, 'action': s:action.gengar },
         \ 'skeleton': { 'icon': '!', 'name': 'skeleton', 'side': 'monster', 'life': 3, 'mana': 3, 'hate': 0, 'action': s:action.skeleton },
         \ 'element':  { 'icon': '8', 'name': 'element',  'side': 'monster', 'life': 2, 'mana': 5, 'hate': 0, 'action': s:action.element },
         \ 'armor':    { 'icon': '=', 'name': 'armor',    'side': 'monster', 'life': 8, 'mana': 7, 'hate': 0, 'action': s:action.armor },
         \ 'harpy':    { 'icon': '~', 'name': 'harpy',    'side': 'monster', 'life': 4, 'mana': 6, 'hate': 0, 'action': s:action.harpy },
         \ 'fiary':    { 'icon': '*', 'name': 'fiary',    'side': 'monster', 'life': 3, 'mana': 6, 'hate': 0, 'action': s:action.fiary },
         \ 'witch':    { 'icon': '$', 'name': 'witch',    'side': 'monster', 'life': 4, 'mana': 7, 'hate': 0, 'action': s:action.witch }
         \ }
" }}}
" let s:braves {{{
let s:braves = {}
let s:braves['list'] = [ 'fighter', 'sword', 'bishop', 'kid', 'lancer', 'tamer', 'rook', 'assassin', 'wizard', 'magician', 'criminal' ]
let s:braves['dict'] = {
         \ 'fighter':  { 'icon': 'F', 'name': 'fighter',  'side': 'brave', 'life': 4, 'mana': 5, 'hate': 0, 'action': s:action.fighter },
         \ 'sword':    { 'icon': 'S', 'name': 'sword',    'side': 'brave', 'life': 5, 'mana': 5, 'hate': 0, 'action': s:action.sword },
         \ 'bishop':   { 'icon': 'B', 'name': 'bishop',   'side': 'brave', 'life': 3, 'mana': 5, 'hate': 0, 'action': s:action.bishop },
         \ 'kid':      { 'icon': 'K', 'name': 'kid',      'side': 'brave', 'life': 1, 'mana': 4, 'hate': 0, 'action': s:action.kid },
         \ 'lancer':   { 'icon': 'L', 'name': 'lancer',   'side': 'brave', 'life': 6, 'mana': 8, 'hate': 0, 'action': s:action.lancer },
         \ 'tamer':    { 'icon': 'T', 'name': 'tamer',    'side': 'brave', 'life': 3, 'mana': 6, 'hate': 1, 'action': s:action.tamer },
         \ 'rook':     { 'icon': 'R', 'name': 'rook',     'side': 'brave', 'life': 3, 'mana': 4, 'hate': 0, 'action': s:action.rook },
         \ 'assassin': { 'icon': 'A', 'name': 'assassin', 'side': 'brave', 'life': 3, 'mana': 7, 'hate': 2, 'action': s:action.assassin },
         \ 'wizard':   { 'icon': 'W', 'name': 'wizard',   'side': 'brave', 'life': 3, 'mana': 9, 'hate': 0, 'action': s:action.wizard },
         \ 'magician': { 'icon': 'M', 'name': 'magician', 'side': 'brave', 'life': 3, 'mana': 8, 'hate': 1, 'action': s:action.magician },
         \ 'criminal': { 'icon': 'C', 'name': 'criminal', 'side': 'brave', 'life': 5, 'mana': 5, 'hate': 6, 'action': s:action.criminal }
         \}
" }}}
" function dungeon#monsterlist(...) {{{
function! dungeon#monsterlist(...)
   return s:monsters['list']
endfunction
" }}}
" function dungeon#bravelist(...) {{{
function! dungeon#bravelist(...)
   return s:braves['list']
endfunction
" }}}

""" functions common
" function dungeon#clear() {{{
function! dungeon#clear()
   if s:dungeon['bufnr'] != 0
      if bufexists(s:dungeon['bufnr'])
         call execute(printf('bdelete %s', s:dungeon['bufnr']), 'silent')
      endif
   endif
   let s:dungeon['bufnr'] = 0
   let s:dungeon['posx'] = 0
   let s:dungeon['posy'] = 0
   let s:dungeon['vertical'] = 0
   let s:dungeon['horizontal'] = 0
   let s:master['list'] = []
endfunction
" }}}
" function dungeon#argument(arg) {{{
function! dungeon#checkarg(arg)
   let list = ['tutor']
   for t in list
      if a:arg == t
         return a:arg
      endif
   endfor
   return ''
endfunction
" }}}
" function dungeon#create(obj) {{{
function! dungeon#create(obj)
   call s:message.print(printf('call dungeon#create(%s)', a:obj['name']))
   call s:plain.replace(a:obj['posx'], a:obj['posy'], a:obj['icon'])
   call s:master.add(a:obj)
endfunction
" }}}
" function dungeon#random(...) {{{
function! dungeon#random(...)
   if a:0 == 0
      let l:rand = 2
   else
      let l:rand = a:1
   endif
   let log = -1 * (float2nr(log10(l:rand)) + 1)
   let ret = reltimestr(reltime())[log:]
   return ret % l:rand
endfunction
" }}}
" function dungeon#getobj(x, y) {{{
function! dungeon#getobj(x, y)
   let obj = s:master.exists(a:x, a:y)
   if type(obj) == v:t_dict
      return obj
   endif
   let obj = {}
   let obj['posx'] = a:x
   let obj['posy'] = a:y
   let obj['side'] = 'none'
   if s:plain.isplain(a:x, a:y)
      let obj['icon'] = '.'
      let obj['name'] = 'plain'
   else
      let obj['icon'] = ' '
      let obj['name'] = 'wall'
   endif
   return obj
endfunction
" }}}
" function dungeon#debug() {{{
function! dungeon#debug()
   vnew
   setlocal bufhidden=delete buftype=nofile
   call append(line('$'), '======= dungeon =======')
   for key in keys(s:dungeon)
      call append(line('$'), printf('dungeon.%s: %s', key, s:dungeon[key]))
   endfor
   call append(line('$'), '======= master-list =======')
   for unit in s:master['list']
      call append(line('$'), printf('%s:', unit['name']))
      for key in keys(unit)
         call append(line('$'), printf('  %s: %s', key, unit[key]))
      endfor
   endfor
endfunction
" }}}

""" functions initation
" function dungeon#open() {{{
function! dungeon#open()
   if s:dungeon['bufnr'] == 0
      tabnew [dungeon]
      setlocal filetype=dungeon
      setlocal nobackup noswapfile noundofile
      setlocal bufhidden=delete buftype=nofile
      setlocal nonumber norelativenumber
      setlocal nolist nospell nowrap
      setlocal nocursorline nocursorcolumn
      setlocal guioptions=
      autocmd! QuitPre <buffer> :call dungeon#clear()
      return
   endif
   if !bufexists(s:dungeon['bufnr'])
      echo 'error: buffer not found. -dungeon.vim'
      call dungeon#clear()
      return
   endif
   " MEMO: 分割ウィンドウには対応してない
   let l:loop = v:true
   while l:loop
      let l:bufnr = bufnr('%')
      if s:dungeon['bufnr'] == l:bufnr
         let l:loop = v:false
      else
         normal! gt
      endif
   endwhile
endfunction
" }}}
" function dungeon#makefield() {{{
function! dungeon#makefield()
   let s:dungeon['posx'] = &columns / (2 + dungeon#random(6))
   let s:dungeon['posy'] = &lines   / (2 + dungeon#random(6))
   let s:dungeon['vertical']   = 5 + dungeon#random(3)
   let s:dungeon['horizontal'] = 5 + dungeon#random(3)
   silent normal! ggdG
   call append(line('$'), repeat([''], s:dungeon['posy'] - 1))
   call append(line('$'), repeat(
            \ [repeat(' ', s:dungeon['posx'] - 1) . repeat('.', s:dungeon['horizontal'])],
            \ s:dungeon['vertical'] ))
   silent normal! ggdd
endfunction
" }}}
" function dungeon#keeperstand() {{{
function! dungeon#keeperstand()
   let keeper = deepcopy(s:keeper)
   let [keeper['posx'], keeper['posy']] = s:plain.getplain()
   let keeper['life'] = 10
   let keeper['mana'] = 10
   call dungeon#create(keeper)
endfunction
" }}}
" function dungeon#makegate() {{{
function! dungeon#makegate()
   let gate = deepcopy(s:gate)
   let [gate['posx'], gate['posy']] = s:plain.getplain()
   let gate['life'] = 25
   let gate['mana'] = 10
   call dungeon#create(gate)
endfunction
" }}}
" function dungeon#readfield(arg) {{{
function! dungeon#readfield(arg)
   silent normal! ggdG
   execute 'r ' . s:dungeon['path'] . '\' . a:arg . '.dung'
endfunction
" }}}
" function dungeon#setunits(arg) {{{
function! dungeon#setunits(arg)
   let unitfile = s:dungeon['path'] . '\' . a:arg . '.unit'
   let unitlist = readfile(unitfile)
   for line in unitlist
      let unit = eval(line)
      call dungeon#create(unit)
   endfor
endfunction
" }}}


function! dungeon#make(...)
   let arg = (a:0 ? a:1 : '')
   if arg != ''
      call dungeon#clear()
      let arg = dungeon#checkarg(arg)
   endif
   call dungeon#open()
   if s:dungeon['bufnr'] == 0
      let s:dungeon['bufnr'] = bufnr('%')
      if arg == ''
         call dungeon#makefield()
         call dungeon#keeperstand()
         call dungeon#makegate()
      else
         call dungeon#readfield(arg)
         call dungeon#setunits(arg)
      endif
   endif
   redraw
   let loop = v:true
   while loop
      let loop = s:master['action']()
      call s:master['next']()
      redraw
      sleep 300ms
   endwhile
   quit
endfunction


" vim: set ts=3 sts=3 sw=3 et :
