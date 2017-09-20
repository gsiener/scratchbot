class Forecast

  def initialize(spreadsheet)
    ww = spreadsheet.worksheets[1]

    @current_quarter = ww["E7"].split(" ")[0]
    @target = thousands_to_millions(ww["J9"]) # ACV Goal
    @commit = thousands_to_millions(ww["I9"]) # ACV Field MC
    @achievement = ww["K9"] # % commit
    @top = fetch_top(ww, 43, 62)
  end

  def top_twenty
    @top
  end

  def fetch_top(worksheet, start, stop)
    t = worksheet.rows[start..stop].transpose
    Hash[t[3].zip t[5]]
  end

  def thousands_to_millions(thousands)
    # "$45,123" => "$45M"
    "$" + (thousands.gsub(/\D/,'').to_i/1000).to_s + "M"
  end

  def to_s
    "In " + @current_quarter + ", we're at " + @achievement + " of our " + @target + " target."
  end

end