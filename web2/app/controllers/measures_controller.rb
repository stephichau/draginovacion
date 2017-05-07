class MeasuresController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :set_measure, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /measures
  # GET /measures.json
  def index
    @measures = current_user.measures

    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: "Mediciones vs Fechas")
      data = {}
      cat = []
      @measures.each do |m|
        data[m.kind] ||= []
        data[m.kind] << [m.created_at, m.value]
        cat << m.created_at
      end
      f.xAxis(type: 'datetime')
      f.series(name: "pH", yAxis: 0, data: data[0])
      f.series(name: "N", yAxis: 0, data: data[1])
      f.series(name: "P", yAxis: 0, data: data[2])
      f.series(name: "K", yAxis: 0, data: data[3])

      f.yAxis [
                  {title: {text: "Values", margin: 70} },
              ]

      f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
      f.chart({defaultSeriesType: "spline"})
    end

    @chart_globals = LazyHighCharts::HighChartGlobals.new do |f|
      f.global(useUTC: false)
      f.chart(
          backgroundColor: {
              linearGradient: [0, 0, 500, 500],
              stops: [
                  [0, "rgb(255, 255, 255)"],
                  [1, "rgb(240, 240, 255)"]
              ]
          },
          borderWidth: 2,
          plotBackgroundColor: "rgba(255, 255, 255, .9)",
          plotShadow: true,
          plotBorderWidth: 1
      )
      f.lang(thousandsSep: ",")
      f.colors(["#90ed7d", "#f7a35c", "#8085e9", "#f15c80", "#e4d354"])
    end

  end

  # GET /measures/1
  # GET /measures/1.json
  def show
  end

  # GET /measures/new
  def new
    @measure = Measure.new
  end

  # GET /measures/1/edit
  def edit
  end

  # POST /measures
  # POST /measures.json
  def create
    @measure = Measure.new(measure_params)
    @measure.user = current_user

    respond_to do |format|
      if @measure.save
        format.html { redirect_to @measure, notice: 'Measure was successfully created.' }
        format.json { render :show, status: :created, location: @measure }
      else
        format.html { render :new }
        format.json { render json: @measure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /measures/1
  # PATCH/PUT /measures/1.json
  def update
    respond_to do |format|
      if @measure.update(measure_params)
        format.html { redirect_to @measure, notice: 'Measure was successfully updated.' }
        format.json { render :show, status: :ok, location: @measure }
      else
        format.html { render :edit }
        format.json { render json: @measure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /measures/1
  # DELETE /measures/1.json
  def destroy
    @measure.destroy
    respond_to do |format|
      format.html { redirect_to measures_url, notice: 'Measure was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_measure
      @measure = Measure.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def measure_params
      params.require(:measure).permit(:lat, :lng, :color, :value, :kind)
    end
end
