require 'gossip'

$:.unshift File.expand_path("./../THP_Gossip_Project_Sinatra", __FILE__)

class ApplicationController < Sinatra::Base
  attr_accessor :id

  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end
  #page de creation d'un nouveau gossip
  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    puts "Salut, je suis dans le serveur"
    puts "Ceci est le contenu du hash params : #{params}"
    puts "Trop bien ! Et ceci est ce que l'utilisateur a passé dans le champ gossip_author : #{params["gossip_author"]}"
    puts "De la bombe, et du coup ça, ça doit être ce que l'utilisateur a passé dans le champ gossip_content : #{params["gossip_content"]}"
    puts "Ça déchire sa mémé, bon allez je m'en vais du serveur, ciao les BGs !"
    redirect '/'
  end

  get '/gossips/:id' do
    puts "Voici le numéro du potin que tu veux: : #{params['id']} "
    Gossip.find(params['id'])
    erb :show
  end

  get '/gossips/:id/edit' do
    erb :edit
  end

    post '/gossips/:id/edit' do
    Gossip.update(params["gossip_author"], params["gossip_content"], params[:id].to_i)
    redirect '/'
    puts "pourquoi tu marches pas toi ?"
    end

end
