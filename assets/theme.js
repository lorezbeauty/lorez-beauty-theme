(function () {
  'use strict';

  /* Header scroll behavior */
  const header = document.querySelector('[data-header]');
  const hero = document.querySelector('.hero');

  if (header && hero) {
    header.classList.add('header--transparent');

    const onScroll = () => {
      if (window.scrollY > 80) {
        header.classList.add('header--scrolled');
        header.classList.remove('header--transparent');
      } else {
        header.classList.remove('header--scrolled');
        header.classList.add('header--transparent');
      }
    };

    window.addEventListener('scroll', onScroll, { passive: true });
    onScroll();
  }

  /* Menu drawer */
  const menuBtn = document.querySelector('[data-menu-open]');
  const menuClose = document.querySelector('[data-menu-close]');
  const menuDrawer = document.querySelector('[data-menu-drawer]');

  if (menuBtn && menuDrawer) {
    menuBtn.addEventListener('click', () => {
      menuDrawer.classList.add('is-open');
      document.body.style.overflow = 'hidden';
    });
  }

  if (menuClose && menuDrawer) {
    menuClose.addEventListener('click', () => {
      menuDrawer.classList.remove('is-open');
      document.body.style.overflow = '';
    });

    menuDrawer.querySelector('.menu-drawer__overlay')?.addEventListener('click', () => {
      menuDrawer.classList.remove('is-open');
      document.body.style.overflow = '';
    });
  }

  /* Search overlay */
  const searchOpen = document.querySelector('[data-search-open]');
  const searchClose = document.querySelector('[data-search-close]');
  const searchOverlay = document.querySelector('[data-search-overlay]');

  if (searchOpen && searchOverlay) {
    searchOpen.addEventListener('click', () => {
      searchOverlay.classList.add('is-open');
      searchOverlay.querySelector('input')?.focus();
    });
  }

  if (searchClose && searchOverlay) {
    searchClose.addEventListener('click', () => {
      searchOverlay.classList.remove('is-open');
    });
  }

  /* Announcement bar close */
  const announcementClose = document.querySelector('[data-announcement-close]');
  const announcementBar = document.querySelector('[data-announcement]');

  if (announcementClose && announcementBar) {
    announcementClose.addEventListener('click', () => {
      announcementBar.classList.add('is-hidden');
      sessionStorage.setItem('announcement-closed', '1');
    });

    if (sessionStorage.getItem('announcement-closed')) {
      announcementBar.classList.add('is-hidden');
    }
  }

  /* Carousels */
  document.querySelectorAll('[data-carousel]').forEach((carousel) => {
    const track = carousel.querySelector('[data-carousel-track]');
    const prevBtn = carousel.querySelector('[data-carousel-prev]');
    const nextBtn = carousel.querySelector('[data-carousel-next]');
    const slides = carousel.querySelectorAll('[data-carousel-slide]');

    if (!track || !slides.length) return;

    let index = 0;

    const getVisible = () => {
      const w = window.innerWidth;
      if (w <= 480) return 1;
      if (w <= 768) return 2;
      if (w <= 1024) return 3;
      return 4;
    };

    const update = () => {
      const visible = getVisible();
      const maxIndex = Math.max(0, slides.length - visible);
      index = Math.min(index, maxIndex);
      const slideWidth = slides[0].offsetWidth + 4;
      track.style.transform = `translateX(-${index * slideWidth}px)`;
      if (prevBtn) prevBtn.disabled = index === 0;
      if (nextBtn) nextBtn.disabled = index >= maxIndex;
    };

    prevBtn?.addEventListener('click', () => {
      index = Math.max(0, index - 1);
      update();
    });

    nextBtn?.addEventListener('click', () => {
      index = Math.min(slides.length - getVisible(), index + 1);
      update();
    });

    window.addEventListener('resize', update);
    update();
  });

  /* Market toggle (España / México) */
  const MXN_RATE = 21.5;

  const formatMXN = (eur) =>
    '$' + Math.round(parseFloat(String(eur).replace(',', '.')) * MXN_RATE).toLocaleString('es-MX') + ' MXN';

  function formatEUR(eur) {
    const n = parseFloat(String(eur).replace(',', '.'));
    return '€' + n.toFixed(2).replace('.', ',');
  }

  function formatKitLabel(prefix, eur, market) {
    const price = market === 'mx' ? formatMXN(eur) : formatEUR(eur);
    return (prefix || '') + price;
  }

  function setMarket(market) {
    document.querySelectorAll('[data-market]').forEach((btn) => {
      const active = btn.dataset.market === market;
      btn.classList.toggle('is-active', active);
      btn.setAttribute('aria-pressed', active ? 'true' : 'false');
    });

    document.querySelectorAll('[data-market-panel]').forEach((panel) => {
      panel.classList.toggle('is-visible', panel.dataset.marketPanel === market);
    });

    document.querySelectorAll('[data-price-eur]').forEach((el) => {
      const eur = el.dataset.priceEur;
      if (!eur) return;
      el.textContent = market === 'mx' ? formatMXN(eur) : formatEUR(eur);
    });

    document.querySelectorAll('[data-price]').forEach((el) => {
      const eur = el.dataset.priceEur;
      if (!eur) return;
      el.textContent = market === 'mx' ? formatMXN(eur) : formatEUR(eur);
    });

    document.querySelectorAll('[data-market-copy]').forEach((el) => {
      el.textContent = market === 'mx' ? el.dataset.mx : el.dataset.es;
    });

    const kitBtn = document.getElementById('add-kit-btn');
    if (kitBtn && kitBtn.dataset.priceEur) {
      kitBtn.textContent = formatKitLabel(kitBtn.dataset.kitLabel || 'Add kit to cart — ', kitBtn.dataset.priceEur, market);
    }

    document.querySelectorAll('[data-hero-kit-btn]').forEach((el) => {
      if (!el.dataset.priceEur) return;
      el.textContent = formatKitLabel(el.dataset.labelPrefix || '', el.dataset.priceEur, market);
    });

    localStorage.setItem('lorez-market', market);
  }

  document.querySelectorAll('[data-market]').forEach((btn) => {
    btn.addEventListener('click', () => setMarket(btn.dataset.market));
  });

  const shopCountry = (window.Shopify && window.Shopify.country) || 'ES';
  const defaultMarket = shopCountry === 'MX' ? 'mx' : 'es';
  const savedMarket = localStorage.getItem('lorez-market');
  setMarket(savedMarket === 'mx' || savedMarket === 'es' ? savedMarket : defaultMarket);

  /* Cart toast */
  const cartToast = document.getElementById('cart-toast');

  function showCartToast() {
    if (!cartToast) return;
    cartToast.classList.add('is-visible');
    clearTimeout(showCartToast._timer);
    showCartToast._timer = setTimeout(() => cartToast.classList.remove('is-visible'), 4000);
  }

  document.querySelectorAll('.product-card__form').forEach((form) => {
    form.addEventListener('submit', (e) => {
      e.preventDefault();
      const id = form.querySelector('[name="id"]')?.value;
      if (!id) return;

      fetch('/cart/add.js', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ id, quantity: 1 }),
      })
        .then((res) => {
          if (!res.ok) throw new Error('add failed');
          return res.json();
        })
        .then(() => showCartToast())
        .catch(() => form.submit());
    });
  });

  /* Kit add to cart (multi-variant) */
  const kitBtn = document.getElementById('add-kit-btn');
  if (kitBtn) {
    kitBtn.addEventListener('click', () => {
      const ids = (kitBtn.dataset.kitVariants || '').split(',').filter(Boolean);
      if (!ids.length) return;

      kitBtn.disabled = true;
      kitBtn.setAttribute('aria-busy', 'true');

      Promise.all(
        ids.map((id) =>
          fetch('/cart/add.js', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ id, quantity: 1 }),
          })
        )
      )
        .then(() => showCartToast())
        .finally(() => {
          kitBtn.disabled = false;
          kitBtn.removeAttribute('aria-busy');
        });
    });
  }

  /* Sticky CTA on homepage */
  const stickyCta = document.querySelector('[data-sticky-cta]');
  const kitSection = document.getElementById('kit');

  if (stickyCta && kitSection) {
    const showSticky = () => {
      const kitTop = kitSection.getBoundingClientRect().top;
      const pastHero = window.scrollY > 400;
      const kitVisible = kitTop < window.innerHeight && kitTop > -kitSection.offsetHeight;
      if (pastHero && !kitVisible) {
        stickyCta.hidden = false;
        stickyCta.classList.add('is-visible');
      } else {
        stickyCta.classList.remove('is-visible');
        stickyCta.hidden = true;
      }
    };
    window.addEventListener('scroll', showSticky, { passive: true });
    showSticky();
  }

  /* Product gallery thumbnails */
  document.querySelectorAll('[data-product-gallery]').forEach((gallery) => {
    const slides = gallery.querySelectorAll('[data-gallery-slide]');
    const thumbs = gallery.querySelectorAll('[data-gallery-thumb]');
    if (!slides.length) return;

    thumbs.forEach((thumb) => {
      thumb.addEventListener('click', () => {
        const index = thumb.dataset.index;
        slides.forEach((slide) => slide.classList.toggle('is-active', slide.dataset.index === index));
        thumbs.forEach((t) => t.classList.toggle('is-active', t.dataset.index === index));
      });
    });
  });
})();
