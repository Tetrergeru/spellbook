document.addEventListener("DOMContentLoaded", main)

function main() {
    init_spells()
    init_users()
    init_private()
    init_register()
    init_login()
    init_logout()

    current_user_callback()
}

function init_spells() {
    const button = document.querySelector(".spells_button")
    const text = document.querySelector(".spells_text")

    button.addEventListener('mouseup', () => {
        request('get', '/api/spells')
            .then((res) => res.json())
            .then((json) => text.textContent = JSON.stringify(json, null, 2));
    })
}

function init_users() {
    const button = document.querySelector(".users_button")
    const text = document.querySelector(".users_text")

    button.addEventListener('mouseup', () => {
        request('get', '/api/users')
            .then((res) => res.json())
            .then((json) => text.textContent = JSON.stringify(json, null, 2));
    })
}

function init_private() {
    const button = document.querySelector(".private_button")
    const text = document.querySelector(".private_text")

    button.addEventListener('mouseup', () => {
        console.log('query')
        request('get', '/api/private')
            .then((res) => res.blob())
            .then((res) => res.text())
            .then((json) => text.textContent = json);
    })
}

function init_register() {
    const button = document.querySelector(".register_button")
    const nickname = document.querySelector(".nickname_field")
    const email = document.querySelector(".email_field")
    const password = document.querySelector(".password_field")

    const result = document.querySelector(".result_field")

    button.addEventListener('mouseup', () => {
        let body = {
            nickname: nickname.value,
            email: email.value,
            password: password.value,
        }
        request('POST', '/api/users', JSON.stringify(body))
            .then((res) => res.json())
            .then((json) => {
                result.textContent = JSON.stringify(json, null, 2);
                if (json.access_token) {
                    window.localStorage.setItem('logged_in', true)
                    window.localStorage.setItem('auth_token', json.access_token)
                }
            });
    })
}

function init_login() {
    const button = document.querySelector(".login_button")
    const nickname = document.querySelector(".login_nickname_field")
    const password = document.querySelector(".login_password_field")

    const result = document.querySelector(".login_result_field")

    button.addEventListener('mouseup', () => {
        let body = {
            nickname: nickname.value,
            password: password.value,
        }
        request('POST', '/api/login', JSON.stringify(body))
            .then((res) => res.json())
            .then((json) => {
                result.textContent = JSON.stringify(json, null, 2);
                if (json.access_token) {
                    window.localStorage.setItem('logged_in', true)
                    window.localStorage.setItem('auth_token', json.access_token)
                    window.localStorage.setItem('nickname', body.nickname)
                    current_user_callback()
                }
            })
    })
}

var current_user_callback;

function init_logout() {
    const button = document.querySelector(".logout_button")
    const nickname = document.querySelector(".current_user_field")

    button.addEventListener('mouseup', () => {
        window.localStorage.removeItem('logged_in')
        window.localStorage.removeItem('auth_token')
        window.localStorage.removeItem('nickname')
        current_user_callback()
    })

    current_user_callback = () => {
        if (window.localStorage.getItem('logged_in')) {
            nickname.value = window.localStorage.getItem('nickname')
        } else {
            nickname.value = '<none>'
        }
    }
}

function request(verb, path, body) {
    const headers = {}

    if (window.localStorage.getItem('logged_in')) {
        headers['Authorization'] = `Bearer: ${window.localStorage.getItem('auth_token')}`
    }

    if (body) {
        headers['Accept'] = 'application/json';
        headers['Content-Type'] = 'application/json';
    }

    return fetch(path, {
        method: verb,
        headers: headers,
        body: body
    })
}