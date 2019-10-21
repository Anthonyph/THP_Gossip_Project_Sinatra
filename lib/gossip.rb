require 'pry'
require 'csv'

$:.unshift File.expand_path("./../THP_Gossip_Project_Sinatra", __FILE__)

class Gossip
  attr_accessor :content, :author
  
  def initialize(author, content) # creation de l'instance
  @content = content
  @author = author
  end

  def save_a_moi #méthode pour enregistrer des gossips
    File.open("./db/gossip.csv", "a+") do |file| #append line 'a+'
      file.puts author + "," + content
    end
  end 

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [author, content]
    end
  end 

	def self.all_le_mien
		all_gossips = []
		iterator_lines = 0
		File.open('db/gossip.csv','r').each_line do |line|
			data = line.split(/\t/)
			all_gossips[iterator_lines]= Gossip.new(data[0].split(",").at(0),data[0].split(",").at(1))
			iterator_lines+=1
		end
		return all_gossips
  end

  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end
  
  def self.find(id)
    index = id.to_i - 1
    all_gossips = self.all 
    p all_gossips[index]
    puts all_gossips[index].author
    puts all_gossips[index].content
    return all_gossips[index]
  end

  def self.update(gossip_author_edit, gossip_content_edit, id) #modifie @content comme le change state du morpiontre
  
  index = id.to_i - 1
  rows_array =  CSV.open("./db/gossip.csv", "w") #append line 'a+
  
 rows_array[index][0] = gossip_author_edit
 rows_array[index][1] = gossip_content_edit
  
  return rows_array
  end


end # end of class
