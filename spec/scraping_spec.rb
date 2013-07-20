$:.unshift(File.expand_path(File.join(File.dirname(__FILE__),'..','lib')))
require 'eqalert'

require 'mechanize_rspec'
Mechanize::Config.dirname = File.expand_path(File.join(File.dirname(__FILE__),'samples'))

describe Eqalert,"#parse_page" do
  before do
    @agent=Mechanize.new
    @agent.get("http://bousai.tenki.jp/bousai/earthquake/entries?p=1")
    Time.stub(:now) { 
      Time.mktime(2013,7,20,12,0)
    }
  end

  it "returns 20 items per page" do
    items,c= Eqalert::parse_page(@agent.page)
    expect(items.length).to eq 20
  end

  it "returns 9 items from 2013-7-19 12:00 to 7-20 12:00" do
    items,c= Eqalert::parse_page(@agent.page,24*60*60)
    expect(items.length).to eq 9
  end
end
