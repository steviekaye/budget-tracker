document.addEventListener('DOMContentLoaded', () => {
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



});
