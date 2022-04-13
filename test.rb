turn_num,height,width = gets.split.map(&:to_i)

color_map = Array.new(height) { Array.new(width,0) }

player = 1
(turn_num*3).times do
  x,y,size = gets.split.map(&:to_i)
  size.times do |y_i|
    size.times do |x_i|
      next if y+y_i > height-1 || x+x_i > width-1

      case color_map[y+y_i][x+x_i]
      when player
        next
      when 0
        color_map[y+y_i][x+x_i] = player
      else
        ary = [1,2,3] - [player, color_map[y+y_i][x+x_i]]
        color_map[y+y_i][x+x_i] = ary[0]
      end
    end
  end
  player += 1
  player = 1 if player > 3
end

p1,p2,p3 = 0,0,0
color_map.each do |line|
  p1 += line.count(1)
  p2 += line.count(2)
  p3 += line.count(3)
end

puts "#{p1} #{p2} #{p3}"


