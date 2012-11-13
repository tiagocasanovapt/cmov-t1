prawn_document(:page_layout => :landscape, :page_size => "A7") do |pdf| 
  pdf.text "O seu bilhete:", :align => :center, :size=>20, :style => :bold
	pdf.text "\n"
  pdf.text "Data: #{@reserve.reserv_date.to_s}"
  pdf.text "Origem: #{@stop_first[:stop_time].strftime("%H:%M")} - #{@reserve.first_station[:name]} "
  pdf.text "Destino: #{@stop_last[:stop_time].strftime("%H:%M")} - #{@reserve.last_station[:name]} "

  pdf.text "\nCódigo: #{@reserve.ticket}"

  pdf.text "\n\nConserve este bilhete até ao final da viagem", :size => 9, :style => :italic 
end