class PagesController < ApplicationController

  def home
  end

  def about
  end

  def active_runners
    @stats_active = Stat.order('name ASC').group(:name).size.sort_by {|k,v| v}.reverse
  end

  def data_correction
    @stats_all = Stat.all.order('name ASC')
    @stats_group = Stat.order('name ASC').group(:name).size
  end

  def data_correction_complex
    @stats_all = Stat.all.order('name ASC')
    @stats_group = Stat.order('name ASC').group(:name).size
  end

  def set_lowercase
    Stat.all.each do |sta|
      sta.update_attributes :name => sta.name.downcase.titleize
    end
  end

  def correct_name()
    Stat.where("name LIKE ?", "%#{params[:name_to_be_changed]}%").update_all(name: params[:correct_name])
  end

  def auto_correct_name()
    @stats_group = Stat.order('name ASC').group(:name).size
    @stats_group.each_with_index do |(key, value), index|
      if key.present?
        if @stats_group.key?(helpers.reverse_words(key)) 
          if value<@stats_group[helpers.reverse_words(key)]
            #logger.info "==========================================="
            #logger.info "key = #{key}"
            #logger.info "helpers.reverse_words(key) = #{helpers.reverse_words(key)}"
            Stat.where("name LIKE ?", "%#{key}%").update_all(name: helpers.reverse_words(key))
          end
        end
      end  
    end
  end

end
