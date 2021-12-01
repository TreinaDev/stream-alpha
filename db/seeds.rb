# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin1 = FactoryBot.create(:admin)
admin2 = FactoryBot.create(:admin)

client1 = FactoryBot.create(:client)
client2 = FactoryBot.create(:client)
client3 = FactoryBot.create(:client)

client_profile1 = FactoryBot.create(:client_profile, :with_photo, client: client1)
client_profile2 = FactoryBot.create(:client_profile, client: client2)

customer_payment_method1 = FactoryBot.create(:customer_payment_method, client_profile: client_profile1)
credit_card1 = FactoryBot.create(:credit_card_setting, customer_payment_method: customer_payment_method1)

streamer1 = FactoryBot.create(:streamer)
streamer2 = FactoryBot.create(:streamer)
streamer3 = FactoryBot.create(:streamer)

streamer_profile1 = FactoryBot.create(:streamer_profile, :with_photo, streamer: streamer1)
streamer_profile2 = FactoryBot.create(:streamer_profile, streamer: streamer2)

plan1 = FactoryBot.create(:plan, streamers: [streamer1, streamer2, streamer3])
plan2 = FactoryBot.create(:plan)
plan3 = FactoryBot.create(:plan)

content_streamer1 = ContentStreamer.create!({ streamer: streamer1, plan: plan1 })

action = FactoryBot.create(:game_category, name: 'Ação', admin: admin1)
arcade_rhythm = FactoryBot.create(:game_category, name: 'Arcade e Ritmo', admin: admin1)
fighting = FactoryBot.create(:game_category, name: 'Luta e Artes Marciais', admin: admin1)
infinite_platform_races = FactoryBot.create(:game_category, name: 'Plataformas e Corridas Intermináveis', admin: admin1)
hardcore_fighting = FactoryBot.create(:game_category, name: 'Porradaria', admin: admin1)
action_roguelike = FactoryBot.create(:game_category, name: 'Roguelike de Ação', admin: admin1)
tps = FactoryBot.create(:game_category, name: 'Tiro em Terceira Pessoa', admin: admin1)
fps = FactoryBot.create(:game_category, name: 'Tiro em primeira pessoa (FPS)', admin: admin1)
adventure_casual = FactoryBot.create(:game_category, name: 'Aventura e Casual', admin: admin1)
adventure = FactoryBot.create(:game_category, name: 'Aventura', admin: admin1)
casual = FactoryBot.create(:game_category, name: 'Casuais', admin: admin1)
metroidvania = FactoryBot.create(:game_category, name: 'Metroidvania', admin: admin1)
puzzle = FactoryBot.create(:game_category, name: 'Quebra-Cabeça', admin: admin1)
adventure_rpg = FactoryBot.create(:game_category, name: 'RPGs de Aventura', admin: admin1)
visual_novel = FactoryBot.create(:game_category, name: 'Romance Visual', admin: admin1)
exceptional_plot = FactoryBot.create(:game_category, name: 'Trama Excepcional', admin: admin1)
rpg = FactoryBot.create(:game_category, name: 'RPG', admin: admin1)
jrpg = FactoryBot.create(:game_category, name: 'JRPG', admin: admin1)
action_rpg = FactoryBot.create(:game_category, name: 'RPG de Ação', admin: admin1)
strategy_rpg = FactoryBot.create(:game_category, name: 'RPG de Estratégia', admin: admin1)
rpg_in_groups = FactoryBot.create(:game_category, name: 'RPGs em Grupos', admin: admin1)
rpg_in_turns = FactoryBot.create(:game_category, name: 'RPGs em Turnos', admin: admin1)
roguelike = FactoryBot.create(:game_category, name: 'Roguelike', admin: admin1)
simulator = FactoryBot.create(:game_category, name: 'Simulador', admin: admin1)
construction_automation = FactoryBot.create(:game_category, name: 'Construção e Automação', admin: admin1)
dating_simulator = FactoryBot.create(:game_category, name: 'Encontros', admin: admin1)
space_aviation = FactoryBot.create(:game_category, name: 'Espaço e Aviação', admin: admin1)
physics = FactoryBot.create(:game_category, name: 'Física e "Faça o que quiser"', admin: admin1)
business = FactoryBot.create(:game_category, name: 'Gestão de Negócios', admin: admin1)
rural_manufacturing = FactoryBot.create(:game_category, name: 'Rurais e de Fabricação', admin: admin1)
life_immersive = FactoryBot.create(:game_category, name: 'Vida e Imersivos', admin: admin1)
strategy = FactoryBot.create(:game_category, name: 'Estratégia', admin: admin1)
city_colonies = FactoryBot.create(:game_category, name: 'Cidades e Colônias', admin: admin1)
tower_defense = FactoryBot.create(:game_category, name: 'Defesa de Torres', admin: admin1)
strategy_in_turns = FactoryBot.create(:game_category, name: 'Estratégia Baseada em Turnos', admin: admin1)
rts = FactoryBot.create(:game_category, name: 'Estratégia em Tempo Real (RTS)', admin: admin1)
four_x = FactoryBot.create(:game_category, name: 'Grande Estratégia e 4X', admin: admin1)
military = FactoryBot.create(:game_category, name: 'Militar', admin: admin1)
board_cards = FactoryBot.create(:game_category, name: 'Tabuleiro e Cartas', admin: admin1)
sport_racing = FactoryBot.create(:game_category, name: 'Esporte e Corrida', admin: admin1)
racing = FactoryBot.create(:game_category, name: 'Corrida', admin: admin1)
team_sports = FactoryBot.create(:game_category, name: 'Esporte em Equipe', admin: admin1)
sports = FactoryBot.create(:game_category, name: 'Esportes', admin: admin1)
individual_sports = FactoryBot.create(:game_category, name: 'Esportes Individuais', admin: admin1)
fishing_hunting = FactoryBot.create(:game_category, name: 'Pescaria e Caça', admin: admin1)
sports_simulator = FactoryBot.create(:game_category, name: 'Simuladores de Esporte', admin: admin1)
racing_simulator = FactoryBot.create(:game_category, name: 'Simulação de Corrida', admin: admin1)
anime = FactoryBot.create(:game_category, name: 'Anime', admin: admin1)
space = FactoryBot.create(:game_category, name: 'Espaciais', admin: admin1)
sci_fi_cyberpunk = FactoryBot.create(:game_category, name: 'Ficção científica e cyberpunk', admin: admin1)
mistery_detective = FactoryBot.create(:game_category, name: 'Mistério e detetive', admin: admin1)
open_world = FactoryBot.create(:game_category, name: 'Mundo Aberto', admin: admin1)
survival = FactoryBot.create(:game_category, name: 'Sobrevivência', admin: admin1)
horror = FactoryBot.create(:game_category, name: 'Terror', admin: admin1)
online_competitive = FactoryBot.create(:game_category, name: 'Competitivo Online', admin: admin1)
coop = FactoryBot.create(:game_category, name: 'Cooperativo', admin: admin1)
mmo = FactoryBot.create(:game_category, name: 'MMO', admin: admin1)
multiplayer = FactoryBot.create(:game_category, name: 'Multijogador', admin: admin1)
local_party_multiplayer = FactoryBot.create(:game_category, name: 'Multijogador Local e em Grupo', admin: admin1)
local_network = FactoryBot.create(:game_category, name: 'Rede Local (LAN)', admin: admin1)
singleplayer = FactoryBot.create(:game_category, name: 'Um Jogador', admin: admin1)
game_category1 = FactoryBot.create(:game_category, admin: admin2, created_at: 60.days.ago)
game_category2 = FactoryBot.create(:game_category, admin: admin2, created_at: 59.days.ago)
game_category3 = FactoryBot.create(:game_category, admin: admin2, created_at: 58.days.ago)
game_category4 = FactoryBot.create(:game_category, admin: admin2, created_at: 57.days.ago)
game_category5 = FactoryBot.create(:game_category, admin: admin2, created_at: 56.days.ago)
game_category6 = FactoryBot.create(:game_category, admin: admin2, created_at: 55.days.ago)

game1 = FactoryBot.create(:game)
game2 = FactoryBot.create(:game)
game3 = FactoryBot.create(:game)

video1 = Video.create!(name: 'Gameplay do beta do Battlefield!', description: 'O jogo está muito bugado...', link: '946275951', game: game1, streamer: streamer1)
video2 = FactoryBot.create(:video, :approved, streamer: streamer1, link: '76979871', game: game1)
video3 = FactoryBot.create(:video, streamer: streamer2, link: '647748643', game: game2)
video4 = FactoryBot.create(:video, streamer: streamer1, link: '83558749', game: game3)
video5 = FactoryBot.create(:video, streamer: streamer1)
video6 = FactoryBot.create(:video, streamer: streamer2)
video7 = FactoryBot.create(:video, :refused, streamer: streamer1)

loose_video_price = Price.create!(value: 10.00, loose: true, video: video1)

playlist1 = FactoryBot.create(:playlist, videos: [video1, video2], streamers: [streamer1, streamer2])
