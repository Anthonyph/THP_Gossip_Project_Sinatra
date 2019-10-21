require 'pry'
require 'csv'

$:.unshift File.expand_path("./../THP_Gossip_Project_Sinatra", __FILE__)

class Gossip
  attr_accessor :content, :author
  
  def initialize(author, content)
  @content = content
  @author = author
  end

  def save #méthode pour enregistrer des gossips
    File.open("./db/gossip.csv", "a+") do |file| #append line 'a+'
      file.puts author+","+content
    end
  end 

  def save_du_cours
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << ["Mon super auteur", "Ma super description"]
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

end # end of class


