let itemFilterTimer;
let itemFilterValue = "";

function initItemFilter() {
  const input = document.querySelector("#item_filter.check_list_edit");
  const clearButton = document.querySelector("#item_filter_clear");
  const spinner = document.querySelector(".spinner");

  if (!input) return;

  const itemFilterAction = () => {
    const pattern = new RegExp(input.value, "i");

    document.querySelectorAll(".noborder").forEach(container => {
      let shownCount = 0;

      container.querySelectorAll(".checklist_item").forEach(item => {
        const label = item.querySelector("label");
        if (label && pattern.test(label.textContent)) {
          item.style.display = "";
          shownCount++;
        } else {
          item.style.display = "none";
        }
      });

      container.style.display = shownCount === 0 ? "none" : "";
    });

    itemFilterValue = input.value;

    if (input.value !== "") {
      clearButton.style.visibility = "visible";
    } else {
      clearButton.style.visibility = "hidden";
    }

    if (spinner) spinner.style.visibility = "hidden";
  };

  const timeout = 500;

  // Debounced keyup
  input.addEventListener("keyup", () => {
    if (itemFilterValue !== input.value) {
      clearTimeout(itemFilterTimer);
      itemFilterTimer = setTimeout(itemFilterAction, timeout);
      if (spinner) spinner.style.visibility = "visible";
    }
  });

  // Cancel debounce on keydown
  input.addEventListener("keydown", () => {
    clearTimeout(itemFilterTimer);
    if (spinner) spinner.style.visibility = "hidden";
  });

  // Clear button click
  clearButton.addEventListener("click", () => {
    clearButton.style.visibility = "hidden";
    input.value = "";
    itemFilterAction();
  });
}

function initGroupCheckboxToggle() {
  document.querySelectorAll("h3").forEach(header => {
    header.addEventListener("click", () => {
      const parent = header.parentElement;
      if (!parent) return;
      const checkboxes = parent.querySelectorAll('input[type="checkbox"]');
      if (checkboxes.length === 0) return;

      const shouldCheck = !checkboxes[0].checked;
      checkboxes.forEach(cb => (cb.checked = shouldCheck));
    });
  });
}

// run when DOM ready
document.addEventListener("turbo:load", () => {
  initItemFilter();
  initGroupCheckboxToggle();
});