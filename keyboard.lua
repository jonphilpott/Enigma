local qwerty="qwertyuiopasdfghjklzxcvbnm"

function ssplit(s)
   local t = {}

   for i=1,#s do
      table.insert(t, string.sub(s, i, i))
   end

   return t
end



function CreateKeyboard()
   keyb = {}
   keyb.qwerty_chars = ssplit(qwerty)
   keyb.current_chars = ssplit(qwerty)
   keyb.map = {}
   keyb.shuffle_rounds = 24


   function keyb:reset_to_qwerty()
      love.math.setRandomSeed(42)
      keyb.current_chars = ssplit(qwerty)
      keyb:update_map()
   end
   
   function keyb:get_qwerty_chars()
     return qwerty.qwerty_chars
   end
   
   function keyb:print_map()
      for i=1,#keyb.current_chars do
	 print(keyb.current_chars[i])
      end
   end
   
   function keyb:update_map()
      for i=1,#keyb.current_chars do
	 keyb.map[keyb.qwerty_chars[i]] =
	    keyb.current_chars[i]
      end
   end

   function keyb:translate_char(c)
      l = string.lower(c)
      return keyb.map[l]
   end

   function keyb:shuffle(c)
      local sz = #keyb.current_chars
      for r=1,string.byte(c) do
	 for i=1,sz do
	    s = keyb.current_chars[i]
	    d = love.math.random(sz)
	    dc = keyb.current_chars[d]
	    keyb.current_chars[i] = dc
	    keyb.current_chars[d] = s
	 end
      end
      
      keyb:update_map()
   end

   keyb:reset_to_qwerty()
   
   return keyb;
end
