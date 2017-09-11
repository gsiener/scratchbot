class Forecast
  @current_quarter
  @target
  @commit
  @achievement

  def initialize(spreadsheet)
    ww = spreadsheet.worksheets[1]

    @current_quarter = ww["E7"].split(" ")[0]
    @target = ww["J9"] # ACV Goal
    @commit = ww["I9"] # ACV Field MC
    @achievement = ww["K9"] # % commit
  end

  def to_s
    "In " + @current_quarter + ", we're at " + @achievement + " of our " + @target + " target."
  end

  def to_json
    to_s.to_json
  end

end