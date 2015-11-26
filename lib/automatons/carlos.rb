class Carlos < Automaton
  def prepare_to_play
    @channel = 3
  end

  def move
    while @game.rack.channel_full?(@channel)
      need_to_defend = defend
      if need_to_defend < 0
        @channel += 1
        @channel = 1 if @channel > 7 
      else
        @channel = need_to_defend
      end
    end
    puts @channel
    @channel
  end

  def find_pattern
    me = self.team_name == 'ex' ? 'x' : 'o'
  end

  def defend
    me = find_pattern
    if me == 'o'
      cells = @game.rack.find_location(" xxx") + @game.rack.find_location("xxx ")
    elsif me = 'x'
      cells = @game.rack.find_location(" ooo") + @game.rack.find_location("ooo ")
    end
    defensive_move = cells.flatten.uniq.map(&:address) & @game.rack.playable_cells
    defensive_move.empty? ?  -1 : defensive_move.first.first.to_i
  end
end