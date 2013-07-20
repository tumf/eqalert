# -*- coding: utf-8 -*-
require 'rubygems'
require 'bundler/setup'
require 'mechanize'

require "eqalert/version"

module Eqalert
  URL="http://bousai.tenki.jp/bousai/earthquake/entries?p=%d"

  def parse_id tr
    el = tr.at("td[1]/a")
    /detail-(\d+).html/ =~ el.attr("href") ? $1 : false
  end

  def parse_time tr
    el = tr.at("td[2]")
    return nil unless el
    h = {}
    if /(\d+)年(\d+)月(\d+)日/ =~ el.inner_text
      h[:year] = $1
      h[:month] = $2
      h[:day] = $3
    end
    if /(\d+)時(\d+)分/ =~ el.inner_text
      h[:hour] = $1
      h[:min] = $2
    end
    Time.mktime(h[:year],h[:month],h[:day],h[:hour],h[:min])
  end

  def parse_area tr
    tr.at("td[3]").inner_text
  end

  def parse_power tr
    tr.at("td[4]").inner_text
  end

  def parse_item tr
    {
      :id => parse_id(tr),
      :time => parse_time(tr),
      :area => parse_area(tr),
      :power => parse_power(tr)
    }
  rescue
    nil
  end

  def parse_page page,last = false
    continue = true
    [page.search("table#earthquake_recent_entries_table tr").collect { |tr|
       item = parse_item(tr)
       if (item && last && (Time.now - last) > item[:time])
         continue = false
       end
       continue ? item : nil
    }.compact,continue]
  end

  # @last 現在からの秒数
  def fetch(last,max = 200)
    agent = Mechanize.new
    (1..max).each { |n|
      agent.get(URL % n) { |page|
        data,continue = parse_page(page,last)
        break unless continue
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
    area = areas.max { |a, b| a[1] <=> b[1] }
    return area[1] if area
    0
  end

  module_function :alert, :fetch, :parse_page, :parse_item, :parse_id, :parse_time, :parse_area, :parse_power
end

