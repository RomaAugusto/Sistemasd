/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


let timeout;

function resetTimer() {
    clearTimeout(timeout);
    // Establece el tiempo de inactividad (en milisegundos)
    timeout = setTimeout(logout, 5 * 60 * 1000); 
}

function logout() {
    window.location.href = 'CerrarSesion';
}


window.onload = resetTimer;
window.onmousemove = resetTimer;
window.onkeypress = resetTimer;
window.ontouchstart = resetTimer; 







