
def cal_short(string, energy)
#	puts string
	h = Hash.new
	a = Array.new
	mid = -1
	ce = 0
	string.chars.each_with_index do |e, i|
	
		if(e == '0')
			ce -= 2
		elsif(e == '1')
			ce += 3
		elsif(e == '2')
			ce += energy
			mid = i
		end 	

		if(!h[ce])
			h[ce] = Array.new
		end
		h[ce].push(i)
		a[i] = ce
	end
	# puts a
	# puts h

	max_len = 0
	string.chars.each_with_index do |e, i|
		max_0 = max_1 = 0
		lv = 0 
		if(e == '0')
			lv = a[i] + 2			
		elsif(e == '1')
			lv = a[i] - 3
		elsif(e == '2')
			lv = a[i] - energy
		end
		
		max_0 = h[lv] != nil ? h[lv].max : i
		max_1 = h[lv + 1] != nil ? h[lv + 1].max : i
		
		max01 = [max_0, max_1].max
		max01 = a.last >= lv ? a.length - 1 : max01	
		if(max01 >= mid)

			max_len = max_len > max01 - i + 1 ? max_len : max01 - i + 1
			 #puts "max01: #{max01}, i: #{i}, mid: #{mid}"
			if(string[max01] == '0' and max_len == 1)
				max_len = 0
			end
		end	
	
		if(i == mid)
			break
		end
	end
	# puts "rest len:#{max_len}"
	return max_len
end


def cal()
	k, s = gets.chomp.split(' ')
	k = k.to_i
	#puts "length: #{s.length}"
	
	if(k > 2)
		crt = 0
		la = Array.new
		s.chars.each do |e|
			crt += e == '0' ? -2 : 3
			la.push(crt)
		end
		e = crt
		
		crt = 0
		ra = Array.new
		s.chars.reverse_each do |e|
			crt += e == '0' ? -2 : 3
			ra.push(crt)
		end

		lm = la.each_with_index.max
		rm = ra.each_with_index.max
		 #puts "lm:#{lm}, rm:#{rm}"
		
		totalE = 0
		totalL = 0
		remainL = s
		remainR = s
		if(lm[0] > 0)
			totalE += lm[0]
			totalL += lm[1] + 1
			remainR = s.slice(lm[1] + 1, s.length)
		end
		if(rm[0] > 0)
			totalE += rm[0]
			totalL += rm[1] + 1
			remainL = s.slice(0, s.length - rm[1] - 1)
		end

		#puts "e:#{e}, totalE:#{totalE}"
		if(e >= 0)
			return k * s.length
		elsif(totalE + e >= 0)
			num = (totalE / e.abs) < (k - 2) ? (totalE / e.abs) : (k - 2)
			 #puts "num: #{num}, totalE: #{totalE}, totalL: #{totalL}"
			len = num * s.length + totalL
			# puts "len: #{len}"
			remain = totalE + num * e
			# puts "remain: #{remain}"
			if(remain > 0)		
				# use the remaining energy to make it longer
				rest = remainL + '2' + remainR
				#puts "rest: #{rest}, remain: #{remain}"
				# the short array passed to function contains 1 pseudo char
				# remove that from the length 
				len += cal_short(rest, remain) - 1
			end
			return len 
		else
			if(k >= 2)
				return cal_short(s+s, 0)
			else
				return cal_short(s, 0)
			end
		end

	else
		ss = String.new
		k.times do
			ss += s
		end
		
		return cal_short(ss, 0)
	end

end

def main()
	puts cal()
end

main()
