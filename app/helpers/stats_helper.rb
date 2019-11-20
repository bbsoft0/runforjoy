module StatsHelper

  def reverse_words(full_name)
    reversed_name = "###NotExists###"
    if full_name.present?
      word_count = full_name.split.size
      if (word_count==2)
        reversed_name = [full_name.split.last,full_name.split.first].join(' ').squeeze(' ')
      end
      if (word_count==3)
        middle_name=full_name.split[1]
        reversed_name = [full_name.split.last,full_name.split.first].join(' ').squeeze(' ')
      end
    end   
    reversed_name
  end

end
