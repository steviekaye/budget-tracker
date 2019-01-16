document.addEventListener('DOMContentLoaded', () => {
  enableCategoryToggle();
  enableSubcategoryToggle();
});

function enableSubcategoryToggle() {
  const categoryContainers = document.querySelectorAll(".js-subcategory-container")

  categoryContainers.forEach(categoryContainer => {
    const icon = categoryContainer.querySelector(".js-edit-subcategory-icon")
    const button = categoryContainer.querySelector(".js-subcategory")
    const editCategory = categoryContainer.querySelector(".js-edit-subcategory")

    icon.addEventListener("click", () => {
      editCategory.classList.add("active")
      button.classList.toggle("active")
    })
  })
}


function enableCategoryToggle() {
  const titleContainers = document.querySelectorAll(".js-category-container")

  titleContainers.forEach(titleContainer => {
    const icon = titleContainer.querySelector(".js-edit-category-icon")
    const button = titleContainer.querySelector(".js-category")
    const editCategory = titleContainer.querySelector(".js-edit-category")

    icon.addEventListener("click", () => {
      editCategory.classList.add("active")
      button.classList.toggle("active")
    })
  })
}
