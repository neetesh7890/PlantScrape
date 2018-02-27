require 'pry'
require 'mechanize'
require 'spreadsheet'
class PlantScrape
  # def is_native_or_naturalized page2
  #   return 'NATIVE' if page2.search(".bodyText").text.include? 'NATIVE'
  #   return 'NATURALIZED' if page2.search(".bodyText").text.include? 'NATURALIZED'
  #   return 'NA'
  # end
end

alplabets = ['A']#,'B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']

excel_hash = {}

alplabets.each do |alpha|
  agent = Mechanize.new
  
  begin
    agent.get "http://ucjeps.berkeley.edu/eflora/eflora_index.php?index=#{alpha}"
    puts "Scrapping started for alphabet #{alpha}"
    page = agent.page
    plant_index = -1
    start = 0
    excel_hash[alpha] = {}

    page.links.each_with_index do |link, index| 
      
      start = index + 1
      break if link.text.include?("↳")
    end

    (start).upto(page.links.count - 3) do |index|
      break if index == 500
      page2 = page.links[index].click

      plant_index += 1
      puts "Scrape for plant number #{plant_index}."
      
      puts index
      
      excel_hash[alpha]["Plant-#{plant_index}"] = {"Record"=>"",
         "Link"=>"",
         "Page_Type"=>"",
         "Full_Name"=>"",
         "Family"=>"",
         "Old-Family"=>"",
         "Genus"=>"",
         "Species"=>"",
         "name_var_ssp_1"=>"",
         "name_var_ssp_2"=>"",
         "Common_Names"=>"",
         "Link_to_Family_Dichotomous_Key"=>"",
         "Link_to_Genus_Dichotomous_Key"=>"",
         "Native_Status"=>"",
         "Description"=>"",
         "Ecology"=>"",
         "Elevation_text"=>"",     
         "Low_Elevation"=>"",
         "High_Elevation"=>"",
         "Bioregional_Distribution"=>"",
         "Distribution_Outside_California"=>"",
         "Flowering_Time_text"=>"",
         "Flowering_Start"=>"",
         "Flowering_End"=>"",
         "Note"=>"",
         "Link_to_Jepson_Diagram"=>"",
         "Link_to_Calphotos"=>"",
         "IPC_Listed_weed"=>"",
         "Synonyms_1"=>"",
         "Synonyms_1_Genus"=>"",
         "Synonyms_1_Species"=>"",
         "Synonyms_1_name_var_ssp_1"=>"",
         "Synonyms_1_name_var_ssp_2"=>"",
         "Synonyms_2"=>"",
         "Synonyms_2_Genus"=>"",
         "Synonyms_2_Species"=>"",
         "Synonyms_2_name_var_ssp_1"=>"",
         "Synonyms_2_name_var_ssp_2"=>"",
         "Synonyms_3"=>"",
         "Synonyms_3_Genus"=>"",
         "Synonyms_3_Species"=>"",
         "Synonyms_3_name_var_ssp_1"=>"",
         "Synonyms_3_name_var_ssp_2"=>"",
         "Synonyms_4"=>"",
         "Synonyms_4_Genus"=>"",
         "Synonyms_4_Species"=>"",
         "Synonyms_4_name_var_ssp_1"=>"",
         "Synonyms_4_name_var_ssp_2"=>"",
         "Synonyms_5"=>"",
         "Synonyms_5_Genus"=>"",
         "Synonyms_5_Species"=>"",
         "Synonyms_5_name_var_ssp_1"=>"",
         "Synonyms_5_name_var_ssp_2"=>"",
         "Synonyms_6"=>"",
         "Synonyms_6_Genus"=>"",
         "Synonyms_6_Species"=>"",
         "Synonyms_6_name_var_ssp_1"=>"",
         "Synonyms_6_name_var_ssp_2"=>"",
         "Synonyms_7"=>"",
         "Synonyms_7_Genus"=>"",
         "Synonyms_7_Species"=>"",
         "Synonyms_7_name_var_ssp_1"=>"",
         "Synonyms_7_name_var_ssp_2"=>"",
         "Synonyms_8"=>"",
         "Synonyms_8_Genus"=>"",
         "Synonyms_8_Species"=>"",
         "Synonyms_8_name_var_ssp_1"=>"",
         "Synonyms_8_name_var_ssp_2"=>"",
         "Synonyms_9"=>"",
         "Synonyms_9_Genus"=>"",
         "Synonyms_9_Species"=>"",
         "Synonyms_9_name_var_ssp_1"=>"",
         "Synonyms_9_name_var_ssp_2"=>"",
         "Synonyms_10"=>"",
         "Synonyms_10_Genus"=>"",
         "Synonyms_10_Species"=>"",
         "Synonyms_10_name_var_ssp_1"=>"",
         "Synonyms_10_name_var_ssp_2"=>"",
         "CNPS_Listed"=>"",
         "CNPS_Link"=>"",
         "CNPS_California_Rare_Plant_Rank"=>"",
         "CNPS_Federally_Listed_Status"=>"",
         "CNPS_State_Listing_Status"=>"",
         "CNPS_State_Rank"=>"",
         "CNPS_Global_Rank"=>"",
         "CNPS_Elevation_text"=>"",
         "CNPS_Low_Elevation"=>"",
         "CNPS_High_Elevation"=>"",
         "CNPS_California_Endemic"=>"",
         "CNPS_Other_States"=>"",
         "CNPS_California_Counties_and_Islands"=>"",
         "CNPS_Quads"=>"",
         "CNPS_Lifeform"=>"",
         "CNPS_Blooming_Period"=>"",
         "CNPS_Bloom_Early"=>"",
         "CNPS_Bloom_Start"=>"",
         "CNPS_Bloom_End"=>"",
         "CNPS_Bloom_Late"=>"",
         "CNPS_Habitat"=>""
      }

      excel_hash[alpha]["Plant-#{plant_index}"]["Link"] = page2.uri.to_s
      if page2.uri.to_s.include?("tid=")
        excel_hash[alpha]["Plant-#{plant_index}"]["Record"] = page2.uri.to_s.split("tid=").last unless page2.uri.to_s.nil?
      end
      
      # if page2.uri.to_s.include?("key=")
      #   excel_hash.delete(excel_hash[alpha]["Plant-#{plant_index}"])
      #   next
      # end

      full_name = page2.search(".pageLargeHeading").text unless page2.search(".pageLargeHeading").empty?
      excel_hash[alpha]["Plant-#{plant_index}"]["Full_Name"] = full_name

      plant_array = full_name.nil? ? [] : full_name.split(" ")
      genus = species = name_var_ssp_1 = name_var_ssp_2 = ""
      case plant_array.count
        when 1
          # genus = plant_array[0]
        when 2
          genus = plant_array[0]
          species = plant_array[1]
        when 3
          genus = plant_array[0]
          species = plant_array[1]
          name_var_ssp_1 = plant_array[2]
        when 4
          genus = plant_array[0]
          species = plant_array[1]
          name_var_ssp_1 = plant_array[2]
          name_var_ssp_2 =  plant_array[3]
      end

      if genus == ""
        excel_hash[alpha].delete("Plant-#{plant_index}")
        next
      end

      excel_hash[alpha]["Plant-#{plant_index}"]["Genus"] = genus
      excel_hash[alpha]["Plant-#{plant_index}"]["Species"] = species
      excel_hash[alpha]["Plant-#{plant_index}"]["name_var_ssp_1"] = name_var_ssp_1

      excel_hash[alpha]["Plant-#{plant_index}"]["name_var_ssp_2"] = name_var_ssp_2


      excel_hash[alpha]["Plant-#{plant_index}"]["Common_Names"] = page2.search(".pageMajorHeading").first.children.text unless page2.search(".pageMajorHeading").empty?
      
      count = 0
      unless page2.search(".taxonomy_table").empty?
        count = page2.search(".taxonomy_table")[1].search(".column1").text.split(" ").count unless page2.search(".taxonomy_table")[1].nil?
      end

      if count == 2
        excel_hash[alpha]["Plant-#{plant_index}"]["Family"] = page2.search(".taxonomy_table")[1].search(".column1").text.split(" ").last unless page2.search(".taxonomy_table").empty?
      elsif count == 3
        excel_hash[alpha]["Plant-#{plant_index}"]["Family"] = page2.search(".taxonomy_table")[1].search(".column1").text.split(" ")[1] unless page2.search(".taxonomy_table").empty?
        excel_hash[alpha]["Plant-#{plant_index}"]["Old-Family"] = page2.search(".taxonomy_table")[1].search(".column1").text.split(" ").last.strip.delete("()") unless page2.search(".taxonomy_table").empty?
      end

      unless page2.search(".taxonomy_table").empty?
        unless page2.search(".taxonomy_table")[1].nil?
          excel_hash[alpha]["Plant-#{plant_index}"]["Link_to_Family_Dichotomous_Key"] = page2.search(".taxonomy_table")[1].search(".column3").children[0].attributes["href"].value unless page2.search(".taxonomy_table")[1].search(".column3").children[0].attributes["href"].nil?
        end
      end

      unless page2.search(".taxonomy_table")[2].nil?
        genus_dichotomous_key = page2.search(".taxonomy_table")[2].search(".column3").children[0].attributes["href"].value unless page2.search(".taxonomy_table")[2].search(".column3").children[0].attributes["href"].nil?
        excel_hash[alpha]["Plant-#{plant_index}"]["Link_to_Genus_Dichotomous_Key"] = genus_dichotomous_key
      end

      excel_hash[alpha]["Plant-#{plant_index}"]["Native_Status"] = "NATIVE" if page2.search(".bodyText").text.include? 'NATIVE'
      excel_hash[alpha]["Plant-#{plant_index}"]["Native_Status"] = "NATURALIZED" if page2.search(".bodyText").text.include? 'NATURALIZED'

      description = "Habit:" + page2.search(".bodyText")[2].text.split("Ecology:").first.split("Habit:").last
      excel_hash[alpha]["Plant-#{plant_index}"]["Description"] = description    

      desc = ["Ecology", "Elevation", "Bioregional Distribution", "Outside California", "Flowering Time", "Synonyms", "Note"]
      description_with_value = {}
      
      desc.each do |heading|
        description_with_value[heading] = page2.search(".bodyText")[2].to_s[/#{heading}:(.*?)<b>/m, 1].gsub(/<\/?[^>]*>/, "").strip unless page2.search(".bodyText")[2].to_s[/#{heading}:(.*?)<b>/m, 1].nil?
        
        if heading == "Elevation"
          elevation_txt = Nokogiri::HTML.parse(description_with_value[heading]).text
          excel_hash[alpha]["Plant-#{plant_index}"]["Elevation_text"] = elevation_txt
        elsif heading == "Ecology"
          excel_hash[alpha]["Plant-#{plant_index}"]["Ecology"] = description_with_value[heading]
        elsif heading == "Bioregional Distribution"
          excel_hash[alpha]["Plant-#{plant_index}"]["Bioregional_Distribution"] = description_with_value[heading]
        elsif heading == "Outside California" 
          excel_hash[alpha]["Plant-#{plant_index}"]["Distribution_Outside_California"] = description_with_value[heading]
        elsif heading == "Flowering Time"
          description_with_value[heading] = description_with_value[heading]
          excel_hash[alpha]["Plant-#{plant_index}"]["Flowering_Time_text"] = description_with_value[heading]
        elsif heading == "Note"
          excel_hash[alpha]["Plant-#{plant_index}"]["Note"] = description_with_value[heading]
        end
      end
      
      unless description_with_value["Elevation"].nil?
        elevation_txt = Nokogiri::HTML.parse(description_with_value["Elevation"]).text
        
        if elevation_txt.include?("--")
          excel_hash[alpha]["Plant-#{plant_index}"]["Low_Elevation"] = elevation_txt.split("--").first + " m"
          excel_hash[alpha]["Plant-#{plant_index}"]["High_Elevation"] = elevation_txt.split("--").last
        elsif elevation_txt.include?("<")
          excel_hash[alpha]["Plant-#{plant_index}"]["High_Elevation"] = elevation_txt.split("<").last.strip
          excel_hash[alpha]["Plant-#{plant_index}"]["Low_Elevation"] = ""
        elsif elevation_txt.include?(">")
          excel_hash[alpha]["Plant-#{plant_index}"]["Low_Elevation"] = elevation_txt.split(">").last.strip
          excel_hash[alpha]["Plant-#{plant_index}"]["High_Elevation"] = ""
        end
      end

      unless description_with_value["Flowering Time"].nil?
        excel_hash[alpha]["Plant-#{plant_index}"]["Flowering_Start"] = description_with_value["Flowering Time"].split("--").first
        excel_hash[alpha]["Plant-#{plant_index}"]["Flowering_End"] = description_with_value["Flowering Time"].split("--").last
      else 
        excel_hash[alpha]["Plant-#{plant_index}"]["Flowering_Start"] = excel_hash[alpha]["Plant-#{plant_index}"]["followering_end"] = ""
      end

      excel_hash[alpha]["Plant-#{plant_index}"]["Link_to_Jepson_Diagram"] = page2.image_with(src: /illustrations/).uri.to_s unless page2.image_with(src: /illustrations/).nil?
      
      link_to_calphotos = ""
      page2.links.each do |link|
        if link.text.include?("CalPhotos")
          link_to_calphotos = link.uri.to_s
          break
        else
          link_to_calphotos = "NA"
        end
      end
      excel_hash[alpha]["Plant-#{plant_index}"]["Link_to_Calphotos"] = link_to_calphotos

      excel_hash[alpha]["Plant-#{plant_index}"]["IPC_Listed_weed"] = page2.link_with(text: "Weed listed by Cal-IPC").nil? ? 'No' : 'YES' 
      
      unless description_with_value["Synonyms"].nil?
        synonyms = Nokogiri::HTML.parse description_with_value["Synonyms"]

        synonyms.text.split(";").each_with_index do |synonym, index|
          gen = spec = ssp_1 = ssp_2 = ""
          if synonym.include?('var.') || synonym.include?('ssp.') || synonym.include?('subsp.') 
            gen = synonym.split(" ")[0]
            spec = synonym.split(" ")[1]
            ssp_1 = synonym.split(" ")[2]
            ssp_2 = synonym.split(" ")[3]
          else
            gen = synonym.split(" ")[0]
            spec = synonym.split(" ")[1]
          end
          modified_synonym = "#{gen} #{spec} #{ssp_1} #{ssp_2}"
          excel_hash[alpha]["Plant-#{plant_index}"]["Synonyms_#{index+1}"] = modified_synonym
          excel_hash[alpha]["Plant-#{plant_index}"]["Synonyms_#{index+1}_Genus"] = gen
          excel_hash[alpha]["Plant-#{plant_index}"]["Synonyms_#{index+1}_Species"] = spec
          excel_hash[alpha]["Plant-#{plant_index}"]["Synonyms_#{index+1}_name_var_ssp_1"] = ssp_1
          excel_hash[alpha]["Plant-#{plant_index}"]["Synonyms_#{index+1}_name_var_ssp_2"] = ssp_2
        end
      end


      cnps_listed = page2.link_with(text: "Listed on CNPS Rare Plant Inventory").nil? ? 'NO' : 'YES'
      excel_hash[alpha]["Plant-#{plant_index}"]["CNPS_Listed"] = cnps_listed

      if cnps_listed == "YES"
        excel_hash[alpha]["Plant-#{plant_index}"]["CNPS_Link"] = page2.link_with(text: "Listed on CNPS Rare Plant Inventory").uri.to_s
        
        cnps_page = page2.link_with(text: "Listed on CNPS Rare Plant Inventory").click

        excel_hash[alpha]["Plant-#{plant_index}"]["CNPS_California_Rare_Plant_Rank"] = cnps_page.search('#cnpsCodeSlot').text
        unless cnps_page.search(".box_b .bricks")[1].nil?
          excel_hash[alpha]["Plant-#{plant_index}"]["CNPS_Federally_Listed_Status"] = cnps_page.search(".box_b .bricks")[1].search("li")[1].text.gsub(/\s+/, " ").split(":")[1].strip 
          excel_hash[alpha]["Plant-#{plant_index}"]["CNPS_State_Listing_Status"] = cnps_page.search(".box_b .bricks")[1].search("li")[2].text.gsub(/\s+/, " ").split(":")[1].strip 
          excel_hash[alpha]["Plant-#{plant_index}"]["CNPS_State_Rank"] =  cnps_page.search(".box_b .bricks")[1].search("li")[3].text.gsub(/\s+/, "/").split("/")[2] 
          excel_hash[alpha]["Plant-#{plant_index}"]["CNPS_Global_Rank"] = cnps_page.search(".box_b .bricks")[1].search("li")[4].text.gsub(/\s+/, "/").split("/")[2] 
        end
        # Next table 
        # low and high elevation logic remains
        # location_table = {}
        # cnps_page.search("#cont_wrap").search(".bricks .A10").search("li").each do |li|
        #   key = li.text.gsub(/\s+/, " ").split(":").first.strip
        #   value = li.text.gsub(/\s+/, " ").split(":").last.strip
        #   break if key == "Notes"
          
        #   if key == "California Counties and Islands"
        #     location_table[key] = value.split("(code)").last.strip
        #   elsif key == "Quads"
        #     location_table[key] = value.split("USGS code").last.strip
        #   else
        #     location_table[key] = value
        #   end
        # end

        cnps_page.search("#cont_wrap").search(".bricks .A10").search("li").each do |li|
          key = li.text.gsub(/\s+/, " ").split(":").first.strip
          value = li.text.gsub(/\s+/, " ").split(":").last.strip
          break if key == "Notes"
          if key == "California Counties and Islands"
            excel_hash[alpha]["Plant-#{plant_index}"]["CNPS_California_Counties_and_Islands"] = value.split("(code)").last.strip
          elsif key == "Quads"
            excel_hash[alpha]["Plant-#{plant_index}"]["CNPS_Quads"] = value.split("USGS code").last.strip
          elsif key == "Elevation"
            excel_hash[alpha]["Plant-#{plant_index}"]["CNPS_Low_Elevation"] = value.split("-").first.strip unless value.split("-").first.nil?
            excel_hash[alpha]["Plant-#{plant_index}"]["CNPS_High_Elevation"] = value.split("-").last.split(" ").first unless value.split("-").last.nil?
          elsif key == "Other States"
            excel_hash[alpha]["Plant-#{plant_index}"]["CNPS_Other_States"] = value
          elsif key == "California Endemic"
            excel_hash[alpha]["Plant-#{plant_index}"]["CNPS_California_Endemic"] = value
          end
        end
        # unless location_table["Elevation"].nil?
        #   low_elevation = location_table["Elevation"].split("-").first.strip
        #   high_elevation = location_table["Elevation"].split("-").last.split(" ").first
        # end

        # biology_table = {}
        unless cnps_page.search(".box_b .bricks")[0].nil?
          cnps_page.search(".box_b .bricks")[0].search("li").each do |li|
            key = li.text.gsub(/\s+/, " ").split(":").first.strip
            value = li.text.gsub(/\s+/, " ").split(":").last.strip
            if key == "Habitat"
              habitat = []
              li.to_html.split("Habitat:").last.split("<br>").each do |item|
                habitat << item.gsub(/<\/?[^>]*>/, "").strip.gsub(/[^0-9A-Za-z] /, '')
              end
              excel_hash[alpha]["Plant-#{plant_index}"]["CNPS_Habitat"] = habitat[1, habitat.length].join(',') unless habitat.nil?
            elsif key == "Blooming Period"
              excel_hash[alpha]["Plant-#{plant_index}"]["CNPS_Blooming_Period"] = value
              
              excel_hash[alpha]["Plant-#{plant_index}"]["CNPS_Bloom_Early"] = ""
              excel_hash[alpha]["Plant-#{plant_index}"]["CNPS_Bloom_Start"] = ""
              excel_hash[alpha]["Plant-#{plant_index}"]["CNPS_Bloom_End"] = ""
              excel_hash[alpha]["Plant-#{plant_index}"]["CNPS_Bloom_Late"] = ""
              if value.include?("(") || value.include?("[") || value.include?("{")
                period_array = value.gsub(/[\(\)\[\]\{\}]/, '-').split("-")
                case period_array.count
                when 3
                  excel_hash[alpha]["Plant-#{plant_index}"]["CNPS_Bloom_Early"] = period_array.first
                  excel_hash[alpha]["Plant-#{plant_index}"]["CNPS_Bloom_Start"] = period_array[1]
                  excel_hash[alpha]["Plant-#{plant_index}"]["CNPS_Bloom_End"] = period_array[1]
                  excel_hash[alpha]["Plant-#{plant_index}"]["CNPS_Bloom_Late"] = period_array.last
                when 4
                  excel_hash[alpha]["Plant-#{plant_index}"]["CNPS_Bloom_Early"] = period_array.first
                  excel_hash[alpha]["Plant-#{plant_index}"]["CNPS_Bloom_Start"] = period_array[1]
                  excel_hash[alpha]["Plant-#{plant_index}"]["CNPS_Bloom_End"] = period_array[2]
                  excel_hash[alpha]["Plant-#{plant_index}"]["CNPS_Bloom_Late"] = period_array.last
                end
              elsif 
                value.include?("-")
                excel_hash[alpha]["Plant-#{plant_index}"]["CNPS_Bloom_Start"] = value.split("-").first
                excel_hash[alpha]["Plant-#{plant_index}"]["CNPS_Bloom_End"] = value.split("-").last
              end
            elsif key == "Lifeform"
              excel_hash[alpha]["Plant-#{plant_index}"]["CNPS_Lifeform"] = value
            end
          end
        end
      end    
    end
  rescue
    agent.shutdown
    agent = Mechanize.new  
  end
end

book = Spreadsheet::Workbook.new
sheet = book.create_worksheet name: "Scrapped_Data"

excel_hash.each do |alpha, value|
  value.each_with_index do |(plant, val), index|
    header_array = []
    if index == 0
      val.each do |header, v|
        header_array << header
      end
    else
      val.each do |header, v|
        header_array << v
      end
    end
    sheet.row(index).concat header_array
  end
end
book.write('A.xls')