# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = FactoryBot.create(:admin)
admin2 = FactoryBot.create(:admin)

client = FactoryBot.create(:client)
client2 = FactoryBot.create(:client)
client3 = FactoryBot.create(:client)

client_profile = FactoryBot.create(:client_profile, :with_photo, client: client)
client_profile2 = FactoryBot.create(:client_profile, client: client2)

streamer = FactoryBot.create(:streamer)
streamer2 = FactoryBot.create(:streamer)
streamer3 = FactoryBot.create(:streamer)

streamer_profile = FactoryBot.create(:streamer_profile, :with_photo, streamer: streamer)
streamer_profile2 = FactoryBot.create(:streamer_profile, streamer: streamer2)

plan = FactoryBot.create(:plan, streamers: [streamer, streamer2, streamer3])
plan2 = FactoryBot.create(:plan)
plan3 = FactoryBot.create(:plan)

video = FactoryBot.create(:video, streamer: streamer)
video2 = FactoryBot.create(:video, streamer: streamer2)
video3 = FactoryBot.create(:video, streamer: streamer3)

content_streamer = ContentStreamer.create!({ streamer: streamer, plan: plan })

action = FactoryBot.create(:game_category, name: 'Ação', admin: admin)
arcade_rhythm = FactoryBot.create(:game_category, name: 'Arcade e Ritmo', admin: admin)
fighting = FactoryBot.create(:game_category, name: 'Luta e Artes Marciais', admin: admin)
infinite_platform_races = FactoryBot.create(:game_category, name: 'Plataformas e Corridas Intermináveis', admin: admin)
hardcore_fighting = FactoryBot.create(:game_category, name: 'Porradaria', admin: admin)
action_roguelike = FactoryBot.create(:game_category, name: 'Roguelike de Ação', admin: admin)
tps = FactoryBot.create(:game_category, name: 'Tiro em Terceira Pessoa', admin: admin)
fps = FactoryBot.create(:game_category, name: 'Tiro em primeira pessoa (FPS)', admin: admin)
adventure_casual = FactoryBot.create(:game_category, name: 'Aventura e Casual', admin: admin)
adventure = FactoryBot.create(:game_category, name: 'Aventura', admin: admin)
casual = FactoryBot.create(:game_category, name: 'Casuais', admin: admin)
metroidvania = FactoryBot.create(:game_category, name: 'Metroidvania', admin: admin)
puzzle = FactoryBot.create(:game_category, name: 'Quebra-Cabeça', admin: admin)
adventure_rpg = FactoryBot.create(:game_category, name: 'RPGs de Aventura', admin: admin)
visual_novel = FactoryBot.create(:game_category, name: 'Romance Visual', admin: admin)
exceptional_plot = FactoryBot.create(:game_category, name: 'Trama Excepcional', admin: admin)
rpg = FactoryBot.create(:game_category, name: 'RPG', admin: admin)
jrpg = FactoryBot.create(:game_category, name: 'JRPG', admin: admin)
action_rpg = FactoryBot.create(:game_category, name: 'RPG de Ação', admin: admin)
strategy_rpg = FactoryBot.create(:game_category, name: 'RPG de Estratégia', admin: admin)
rpg_in_groups = FactoryBot.create(:game_category, name: 'RPGs em Grupos', admin: admin)
rpg_in_turns = FactoryBot.create(:game_category, name: 'RPGs em Turnos', admin: admin)
roguelike = FactoryBot.create(:game_category, name: 'Roguelike', admin: admin)
simulator = FactoryBot.create(:game_category, name: 'Simulador', admin: admin)
construction_automation = FactoryBot.create(:game_category, name: 'Construção e Automação', admin: admin)
dating_simulator = FactoryBot.create(:game_category, name: 'Encontros', admin: admin)
space_aviation = FactoryBot.create(:game_category, name: 'Espaço e Aviação', admin: admin)
physics = FactoryBot.create(:game_category, name: 'Física e "Faça o que quiser"', admin: admin)
business = FactoryBot.create(:game_category, name: 'Gestão de Negócios', admin: admin)
rural_manufacturing = FactoryBot.create(:game_category, name: 'Rurais e de Fabricação', admin: admin)
life_immersive = FactoryBot.create(:game_category, name: 'Vida e Imersivos', admin: admin)
strategy = FactoryBot.create(:game_category, name: 'Estratégia', admin: admin)
city_colonies = FactoryBot.create(:game_category, name: 'Cidades e Colônias', admin: admin)
tower_defense = FactoryBot.create(:game_category, name: 'Defesa de Torres', admin: admin)
strategy_in_turns = FactoryBot.create(:game_category, name: 'Estratégia Baseada em Turnos', admin: admin)
rts = FactoryBot.create(:game_category, name: 'Estratégia em Tempo Real (RTS)', admin: admin)
four_x = FactoryBot.create(:game_category, name: 'Grande Estratégia e 4X', admin: admin)
military = FactoryBot.create(:game_category, name: 'Militar', admin: admin)
board_cards = FactoryBot.create(:game_category, name: 'Tabuleiro e Cartas', admin: admin)
sport_racing = FactoryBot.create(:game_category, name: 'Esporte e Corrida', admin: admin)
racing = FactoryBot.create(:game_category, name: 'Corrida', admin: admin)
team_sports = FactoryBot.create(:game_category, name: 'Esporte em Equipe', admin: admin)
sports = FactoryBot.create(:game_category, name: 'Esportes', admin: admin)
individual_sports = FactoryBot.create(:game_category, name: 'Esportes Individuais', admin: admin)
fishing_hunting = FactoryBot.create(:game_category, name: 'Pescaria e Caça', admin: admin)
sports_simulator = FactoryBot.create(:game_category, name: 'Simuladores de Esporte', admin: admin)
racing_simulator = FactoryBot.create(:game_category, name: 'Simulação de Corrida', admin: admin)
anime = FactoryBot.create(:game_category, name: 'Anime', admin: admin)
space = FactoryBot.create(:game_category, name: 'Espaciais', admin: admin)
sci_fi_cyberpunk = FactoryBot.create(:game_category, name: 'Ficção científica e cyberpunk', admin: admin)
mistery_detective = FactoryBot.create(:game_category, name: 'Mistério e detetive', admin: admin)
open_world = FactoryBot.create(:game_category, name: 'Mundo Aberto', admin: admin)
survival = FactoryBot.create(:game_category, name: 'Sobrevivência', admin: admin)
horror = FactoryBot.create(:game_category, name: 'Terror', admin: admin)
online_competitive = FactoryBot.create(:game_category, name: 'Competitivo Online', admin: admin)
coop = FactoryBot.create(:game_category, name: 'Cooperativo', admin: admin)
mmo = FactoryBot.create(:game_category, name: 'MMO', admin: admin)
multiplayer = FactoryBot.create(:game_category, name: 'Multijogador', admin: admin)
local_party_multiplayer = FactoryBot.create(:game_category, name: 'Multijogador Local e em Grupo', admin: admin)
local_network = FactoryBot.create(:game_category, name: 'Rede Local (LAN)', admin: admin)
singleplayer = FactoryBot.create(:game_category, name: 'Um Jogador', admin: admin)
game_category = FactoryBot.create(:game_category, admin: admin2, created_at: 60.days.ago)
game_category2 = FactoryBot.create(:game_category, admin: admin2, created_at: 59.days.ago)
game_category3 = FactoryBot.create(:game_category, admin: admin2, created_at: 58.days.ago)
game_category4 = FactoryBot.create(:game_category, admin: admin2, created_at: 57.days.ago)
game_category5 = FactoryBot.create(:game_category, admin: admin2, created_at: 56.days.ago)
game_category6 = FactoryBot.create(:game_category, admin: admin2, created_at: 55.days.ago)

game = FactoryBot.create(:game)
game2 = FactoryBot.create(:game)
game3 = FactoryBot.create(:game)

video = FactoryBot.create(:video, streamer: streamer, link: '76979871', game: game)
video2 = FactoryBot.create(:video, streamer: streamer2, link: '647748643', game: game2)
video3 = FactoryBot.create(:video, streamer: streamer3, link: '83558749', game: game3)

video = FactoryBot.create(:video, streamer: streamer)
video2 = FactoryBot.create(:video, streamer: streamer2)
video3 = FactoryBot.create(:video, streamer: streamer3)
