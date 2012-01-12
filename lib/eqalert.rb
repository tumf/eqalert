# -*- coding: utf-8 -*-
require 'rubygems'
require 'bundler/setup'
require 'mechanize'

require "eqalert/version"

module Eqalert
  URL="http://tenki.jp/earthquake/entries?p=%d"

  # @last 現在からの秒数
  def fetch(last,max = 200)
    data = []
    agent = Mechanize.new
    (1..max).each { |n|
      agent.get(URL % n) { |page|
        page.search("table#seismicInfoEntries tr").each { |tr|
          item = {}
          # p tr
          el = tr.at("td[@class='tdFirst']")
          next unless el
          h = {}
          if /(\d+)年(\d+)月(\d+)日/ =~ el.inner_text
            h[:year] = $1
            h[:month] = $2
            h[:day] = $3
          end
          el = tr.at("td[3]")
          if /(\d+)時(\d+)分/ =~ el.inner_text
            h[:hour] = $1
            h[:min] = $2
          end
          item[:time] = Time.mktime(h[:year],h[:month],h[:day],h[:hour],h[:min])
          
          el = tr.at("td[4]")
          item[:area] = el.inner_text
          el = tr.at("td[5]")
          item[:power] = el.inner_text

          el = tr.at("td[2]/a")
          if /detail-(\d+).html/ =~ el.attr("href")
            item[:id] = $1
          end
          return data if (Time.now - last) > item[:time]
          data << item
          # puts e
        }
      }
    }
    data
  end

  def alert
    data = fetch(12*60*60)
    areas = {}
    areas.default = 0
    data.each { |item|  areas[item[:area]] += 1  }
    areas.keys.sort.each { |area|
      puts "%s %d" % [area,areas[area]]
    }
    areas.max { |a, b| a[1] <=> b[1] }[1]
  end

  module_function :alert, :fetch
end

