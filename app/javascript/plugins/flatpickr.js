import flatpickr from "flatpickr";

const initFlatpickr = () => {
  flatpickr(".datepicker", {
    altInput: true,
    enableTime: true,
    allowInput: true,
    defaultHour: '7'});

}

export { initFlatpickr };
