class Forecast
  @current_quarter
  @target
  @commit
  @achievement

  def initialize(spreadsheet)
    ww = spreadsheet.worksheets[1]

    @current_quarter = ww["E7"].split(" ")[0]
    @target = thousands_to_millions(ww["J9"]) # ACV Goal
    @commit = thousands_to_millions(ww["I9"]) # ACV Field MC
    @achievement = ww["K9"] # % commit
  end

  def thousands_to_millions(thousands)
    # "$45,123" => "$45M"
    "$" + (thousands.gsub(/\D/,'').to_i/1000).to_s + "M"
  end

  def to_s
    "In " + @current_quarter + ", we're at " + @achievement + " of our " + @target + " target."
  end

  def to_json
    to_s.to_json
  end

end