import { Controller } from "@hotwired/stimulus";
import ApexCharts from "apexcharts";

export default class extends Controller {
  static values = { benefit: String, expense: String };

  connect() {
    this.renderChart();
  }

  getBenefitValue() {
    const benefitValue1 = this.benefitValue;
    return JSON.parse(benefitValue1);
  }

  getExpenseValue() {
    const expenseValue1 = this.expenseValue;
    return JSON.parse(expenseValue1);
  }

  getBenefitByMonth(month) {
    if (this.getBenefitValue().length === 0) {
      return 0;
    }
    return this.getBenefitValue().map((benefit) => {
      if (benefit[0] === month) {
        return benefit[1];
      }
      return 0;
    });
  }

  getExpenseByMonth(month) {
    if (this.getExpenseValue().length === 0) {
      return 0;
    }
    return this.getExpenseValue().map((expense) => {
      if (expense[0] === month) {
        return expense[1];
      }
      return 0;
    });
  }

  renderChart() {
    const options = {
      colors: ["#1A56DB", "#FDBA8C"],
      series: [
        {
          name: "Thu",
          color: "#C026D3",
          data: [
            { x: "Jan", y: this.getBenefitByMonth(1) },
            { x: "Feb", y: this.getBenefitByMonth(2) },
            { x: "Mar", y: this.getBenefitByMonth(3) },
            { x: "Apr", y: this.getBenefitByMonth(4) },
            { x: "May", y: this.getBenefitByMonth(5) },
            { x: "Jun", y: this.getBenefitByMonth(6) },
            { x: "Jul", y: this.getBenefitByMonth(7) },
            { x: "Aug", y: this.getBenefitByMonth(8) },
            { x: "Sep", y: this.getBenefitByMonth(9) },
            { x: "Oct", y: this.getBenefitByMonth(10) },
            { x: "Nov", y: this.getBenefitByMonth(11) },
            { x: "Dec", y: this.getBenefitByMonth(12) },
          ],
        },
        {
          name: "Chi",
          color: "#FDBA8C",
          data: [
            { x: "Jan", y: this.getExpenseByMonth(1) },
            { x: "Feb", y: this.getExpenseByMonth(2) },
            { x: "Mar", y: this.getExpenseByMonth(3) },
            { x: "Apr", y: this.getExpenseByMonth(4) },
            { x: "May", y: this.getExpenseByMonth(5) },
            { x: "Jun", y: this.getExpenseByMonth(6) },
            { x: "Jul", y: this.getExpenseByMonth(7) },
            { x: "Aug", y: this.getExpenseByMonth(8) },
            { x: "Sep", y: this.getExpenseByMonth(9) },
            { x: "Oct", y: this.getExpenseByMonth(10) },
            { x: "Nov", y: this.getExpenseByMonth(11) },
            { x: "Dec", y: this.getExpenseByMonth(12) },
          ],
        },
      ],
      chart: {
        type: "bar",
        height: "400px",
        fontFamily: "Inter, sans-serif",
        toolbar: {
          show: false,
        },
      },
      plotOptions: {
        bar: {
          horizontal: false,
          columnWidth: "70%",
          borderRadiusApplication: "end",
          borderRadius: 8,
        },
      },
      tooltip: {
        shared: true,
        intersect: false,
        style: {
          fontFamily: "Inter, sans-serif",
        },
      },
      states: {
        hover: {
          filter: {
            type: "darken",
            value: 1,
          },
        },
      },
      stroke: {
        show: true,
        width: 0,
        colors: ["transparent"],
      },
      grid: {
        show: false,
        strokeDashArray: 4,
        padding: {
          left: 2,
          right: 2,
          top: -14,
        },
      },
      dataLabels: {
        enabled: false,
      },
      legend: {
        show: false,
      },
      xaxis: {
        floating: false,
        labels: {
          show: true,
          style: {
            fontFamily: "Inter, sans-serif",
            cssClass: "text-xs font-normal fill-gray-500 dark:fill-gray-400",
          },
        },
        axisBorder: {
          show: false,
        },
        axisTicks: {
          show: false,
        },
      },
      yaxis: {
        show: false,
      },
      fill: {
        opacity: 1,
      },
    };

    if (this.element && typeof ApexCharts !== "undefined") {
      const chart = new ApexCharts(this.element, options);
      chart.render();
    }
  }
}
