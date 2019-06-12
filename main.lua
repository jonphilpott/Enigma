require("keyboard")

function love.load()

   love.math.setRandomSeed(42)
   
   keyb = CreateKeyboard()
   keyb:print_map()
   last_key = ""

   -- sound effects
   yes_sound = love.audio.newSource("yes.wav", "static")
   no_sound  = love.audio.newSource("no.wav", "static")
   tick_sound = love.audio.newSource("tick.wav", "static")

   last_key_font = love.graphics.newFont(64, "normal")
   phrase_font   = love.graphics.newFont(32, "normal")
   keyboard_font = love.graphics.newFont(32, "normal")
   
   key_rows = {
      ssplit("qwertyuiop"),
      ssplit("asdfghjkl"),
      ssplit("zxcvbnm")
   }

   current_word_index = 1
   current_word = ""
   current_word_letters = {}
   current_letter_index = 1
   current_points = 2048

   score = 0
   
   change_word()
end

function change_word(reset)
   if (reset) then
      current_word_index = 1
   end
   
   current_word = get_word()
   current_word_letters = ssplit(current_word)
   current_letter_index = 1
   current_points = 2048
   keyb:reset_to_qwerty()
end


word_list = {
'pelicometer',
'bruscus',
'xiphosure',
'fraudfully',
'tacso',
'unexemplary',
'archebiosis',
'unequestrian',
'obturator',
'meliorist',
'jackanapish',
'anthroposomatology',
'corruptibleness',
'tufty',
'suggestress',
'asci',
'orewood',
'trixie',
'helonias',
'sitosterol',
'gigman',
'estoile',
'photochronographically',
'paridrosis',
'gemmipares',
'thiocarbamide',
'formamidine',
'unsteck',
'pichiciago',
'chondrography',
'juniorship',
'dimittis',
'veratria',
'emmanuel',
'aortectasia',
'voetian',
'reintimate',
'prejunior',
'unfluttering',
'warl',
'rosied',
'bountifulness',
'columnated',
'restibrachium',
'overpassionately',
'depreter',
'explanator',
'preluder',
'flashly',
'foreside',
'hazardless',
'excamber',
'skippund',
'seerband',
'nonsectional',
'overcircumspect',
'unenvenomed',
'reflexism',
'unenrichableness',
'packery',
'surianaceae',
'paridae',
'subbranched',
'ballaster',
'choachyte',
'sampi',
'ephidrosis',
'madiga',
'justifier',
'zyrenian',
'fandangle',
'papillitis',
'galingale',
'azoflavine',
'nonpathogenic',
'undispatching',
'distruster',
'amplidyne',
'diathermous',
'parabasal',
'diggings',
'speaking',
'tejon',
'cassiterite',
'indictional',
'pericline',
'glyptical',
'cantala',
'queme',
'convinced',
'replenish',
'nondisarmament',
'tearfulness',
'histotome',
'oireachtas',
'decimator',
'keftian',
'subsea',
'supervisionary',
'longshoreman',
'nosepiece',
'bushbuck',
'swam',
'rhizopodal',
'cystosyrinx',
'camelkeeper',
'kench',
'subcingulum',
'sapotoxin',
'hagiographal',
'unincarcerated',
'supertotal',
'impignoration',
'tilestone',
'cacodoxy',
'phytometric',
'zaque',
'tangleroot',
'incantational',
'woeworn',
'deadborn',
'pleuritically',
'aptychus',
'polymeric',
'tentwards',
'teruyuki',
'kindergarten',
'billion',
'unbonded',
'chromascope',
'geonoma',
'heartbreaker',
'cristiform',
'moderato',
'yakman',
'harmonite',
'hives',
'senega',
'toothed',
'chymic',
'readily',
'intracardiac',
'incandescence',
'wantingness',
'aglossa',
'outreach',
'fungistatic',
'tought',
'connellite',
'zonality',
'intramembranous',
'protopyramid',
'exploitive',
'speakless',
'rebook',
'inpolyhedron',
'blepharosynechia',
'yallaer',
'inhesion',
'underchord',
'breasted',
'wasabi',
'bibliophagic',
'recarbon',
'angelico',
'guianese',
'pretendant',
'mysteriousness',
'purloiner',
'tricking',
'sialostenosis',
'arrosive',
'nosology',
'redemise',
'dosiology',
'untransferred',
'macrochira',
'forthtell',
'spermarium',
'junkman',
'bushmaking',
'colisepsis',
'painstaking',
'derogatively',
'unterraced',
'regardance',
'dodecapartite',
'factorial',
'savagely',
'proteida',
'proliferous',
'telharmonium',
'nummary',
'lipodystrophy',
'saxon',
'rodentially',
'ultralaborious',
'inductional',
'porencephalic'
}

function get_word(reset)
   word = word_list[current_word_index]

   current_word_index = current_word_index + 1
   if (current_word_index > #word_list) then
      current_word_index = 1
   end

   return word
end

timer = 0
function love.update(dt)
   timer = timer + dt

   if (timer > 1) then
      tick_sound:play()
      current_points = current_points / 2
      timer = 0
   end

   if (current_points < 1) then
      no_sound:play()
      change_word(true)
   end
   
end

function love.keypressed(key, scancode)
   print("scancode = ", scancode)
   last_key = keyb:translate_char(scancode)

   if (last_key ~= nil) then
      if (last_key == current_word_letters[current_letter_index]) then
	 yes_sound:play()
	 current_points = 2048
	 current_letter_index = current_letter_index + 1
	 score = score + current_points
	 keyb:shuffle(last_key)
      else
	 no_sound:play()
      end

      if (current_letter_index > #current_word_letters) then
	 change_word()
      end
   end
end

function love.draw()
   love.graphics.setColor(1, 1, 1)
   if last_key ~= nil then
      love.graphics.setFont(last_key_font)
      love.graphics.print(last_key, 200, 200)
   end

   love.graphics.setFont(keyboard_font)
   for r=1,3 do
      row = key_rows[r]
      for c=1,#row do
	 char = row[c]
	 if (char == 'f' or char == 'j') then
	    love.graphics.setColor(0, 1, 0)
	 else
	    love.graphics.setColor(1, 1, 1)
	 end
	 love.graphics.print(
	    keyb:translate_char(char),
	    32 + (r * 10) + (38 * c),
	    400 + (32 * r)
	 )
      end
   end


   love.graphics.setFont(last_key_font)
   love.graphics.setColor(1, 1, 0)
   love.graphics.print("score " .. score, 400, 200)
   love.graphics.print(current_points, 400, 264)
   love.graphics.setColor(1, 1, 1)

   love.graphics.setFont(phrase_font)
   for c = 1, #current_word_letters do
      if (c == current_letter_index) then
	 love.graphics.setColor(1.0, 0.0, 0.0)
      else
	 love.graphics.setColor(1, 1, 1)
      end

      love.graphics.print(
	 current_word_letters[c],
	 64 + (c * 32),
	 64)
   end
   
end
