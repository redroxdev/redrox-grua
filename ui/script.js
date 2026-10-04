let totalDuration = 30;
let hideTimeout = null;

const container = document.getElementById('grua-container');
const card = document.getElementById('grua-card');
const badge = document.getElementById('grua-badge');
const title = document.getElementById('grua-title');
const desc = document.getElementById('grua-desc');
const progress = document.getElementById('grua-progress');

window.addEventListener('message', function(event) {
    const data = event.data;
    if (!data || !data.action) return;

    if (hideTimeout) {
        clearTimeout(hideTimeout);
        hideTimeout = null;
    }

    if (data.action === 'start') {
        totalDuration = Number(data.totalSeconds) || 30;
        card.className = 'card warning';
        badge.textContent = 'AVISO MUNICIPAL';
        title.textContent = 'GRÚA EN CAMINO';
        desc.innerHTML = `La grúa pasará a remolcar vehículos vacíos en <strong id="grua-time">${totalDuration}</strong>s`;
        
        progress.style.transition = 'width 1s linear';
        progress.style.width = '100%';

        container.classList.add('show');
    } else if (data.action === 'update') {
        const remaining = Number(data.remainingSeconds);
        const liveTime = document.getElementById('grua-time');
        if (liveTime) {
            liveTime.textContent = remaining;
            liveTime.classList.remove('pulse-anim');
            void liveTime.offsetWidth;
            liveTime.classList.add('pulse-anim');
        }

        const percent = Math.max(0, Math.min(100, (remaining / totalDuration) * 100));
        progress.style.width = `${percent}%`;
    } else if (data.action === 'finished') {
        card.className = 'card success';
        badge.textContent = 'LIMPIEZA COMPLETADA';
        title.textContent = 'GRÚA FINALIZADA';
        desc.innerHTML = `Se remolcaron <strong>${data.deletedCount || 0}</strong> vehículos abandonados del mapa.`;

        progress.style.transition = 'none';
        progress.style.width = '100%';

        container.classList.add('show');

        hideTimeout = setTimeout(() => {
            container.classList.remove('show');
        }, 6000);
    } else if (data.action === 'hide') {
        container.classList.remove('show');
    }
});
