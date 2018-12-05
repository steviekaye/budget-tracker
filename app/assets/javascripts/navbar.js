document.addEventListener('DOMContentLoaded', () => {
  const navbarBurger = document.querySelector('#navbar-burger');

  navbarBurger.addEventListener('click', () => {
    const target = document.getElementById(navbarBurger.dataset.target);

    navbarBurger.classList.toggle('is-active');
    target.classList.toggle('is-active');
  })
});
