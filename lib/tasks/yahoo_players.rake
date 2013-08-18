namespace :yahoo_players do
  desc "Import players from Yahoo!"
  task :import_players => :environment do
    url = "http://football.fantasysports.yahoo.com/f1/101827/players"
    agent = Mechanize.new
    agent.user_agent_alias = 'Mac Safari'
    agent.follow_meta_refresh = true
    page = agent.get(url)
    form = page.form('login_form')
    form.login = "dajukie7"
    form.passwd = "6403astbous3"
    new_page = agent.submit(form)
    # pp new_page
    players = new_page.search(".players tr.odd, .players tr.even")
    pp players.count
    # form.id = "dajukie7"
    # form.password = "6403astbous3"
    # new_page = agent.submit(form, form.buttons.first)
    # pp new_page
  end
end