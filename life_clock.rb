#! /usr/bin/ruby -Ku
# -*- coding:utf-8 -*-

=begin
one line to give the program's name and an idea of what it does.

Copyright (C) 2012 Yusuke Kurihana

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by the
Free Software Foundation; either version 2 of the License,
or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software Foundation,
Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
=end

# life_clock.rb は 一生を24時間に例えた時の今日の時間を表示するプログラムである

# 秒(float型)で与えられる時間を [時間,分,秒]に直す
# === Args
# 浮動小数点数で与えられる秒
# === Return
# 時間、分、秒の3要素からなる配列
def sec2hour(s)
  hours = 0
  minites = 0
  
  while s >= 60.0
    if minites >= 60
      hours += 1
      minites = 0
    end
    s -= 60.0
    minites += 1
  end
  
  return [hours, minites, s]
end

# 得られた現在時刻を文字列に整形し出力する
# === Args
# _obj_ :: 得られた現在時刻
def life_clock_to_string(obj)
  h = obj[0]
  m = obj[1]
  s = obj[2]
  
  printf "life clock: %d:%2d:%5.5f\n", h, m, s
end

# a年 b月 c日に生まれ n年生きる
# === Args
# _i_ :: 年
# _j_ :: 月
# _k_ :: 日
# _m_ :: 寿命
def life_clock(i, j, k, m)
  a = i
  b = j
  c = k
  n = m

  birth_time = Time.local(a, b, c).to_f
  death_time = Time.local(a + n + 1, b, c).to_f - 1.0
  now = Time.now.to_f
  a_sec_of_life = (death_time - birth_time) / (24 * 60 * 60).to_f

  life_clock_to_string(sec2hour((now - birth_time) / a_sec_of_life))
end

# 不正な ARGV かどうかをチェックする
# === Return
# _true_ :: 不正な ARGV 引数
# _false_ :: 正しい ARGV 引数
def invalid_argv?
  ret = false
  month = ARGV[0].to_i
  day = ARGV[1].to_i
  
  unless 1 <= month || month <= 12
    ret = true
  end

  case month
  when 4, 6, 9, 11
    ret = !(1 <= day || day <= 30)
  when 2
    ret = !(1 <= day || day <= 29)
  else
    ret = !(1 <= day || day <= 31)
  end

  return ret
end

# 設問 人生の時計 を行う主たる関数
def main
  if ARGV.length != 2 || invalid_argv?
    puts "invalid arguments"
    puts "usage: ruby #{$0} your_birthmonth your_birthday"
    exit(1)
  end
  
  puts Time.now

  puts "(i)"
  puts "n = 80"
  1990.upto(2000) do |i|
    print "year #{i}: "
    life_clock(i, 9, 28, 80)
  end

  puts "(ii)"
  puts "n = 200"
  1900.upto(2000) do |i|
    print "year #{i}: "
    life_clock(i, 9, 28, 200)
  end
end

main
