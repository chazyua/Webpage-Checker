require 'net/http'
require 'digest'
require 'fileutils'
require 'telegram/bot'
require 'dotenv/load'

# Configuration
URLS = ['https://www.google.com', 'https://www.example.com', 'https://www.anotherexample.com']
HASH_FILE = './last_hash.txt'
TELEGRAM_TOKEN = ENV['TELEGRAM_TOKEN']
CHAT_ID = ENV['CHAT_ID']

def get_website_content(url)
  uri = URI(url)
  response = Net::HTTP.get(uri)
  response
end

def calculate_hash(content)
  Digest::SHA256.hexdigest(content)
end

def read_last_hash(file_path)
  return nil unless File.exist?(file_path)
  File.read(file_path).strip
end

def write_current_hash(file_path, hash)
  File.write(file_path, hash)
end

def send_telegram_message(token, chat_id, message)
  Telegram::Bot::Client.run(token) do |bot|
    bot.api.send_message(chat_id: chat_id, text: message)
  end
end

def main
  URLS.each do |url|
    content = get_website_content(url)
    current_hash = calculate_hash(content)
    last_hash = read_last_hash("#{HASH_FILE}_#{url}")

    if current_hash != last_hash
      send_telegram_message(TELEGRAM_TOKEN, CHAT_ID, "The content of #{url} has changed.")
      write_current_hash("#{HASH_FILE}_#{url}", current_hash)
    end
  end
end

main if __FILE__ == $PROGRAM_NAME
