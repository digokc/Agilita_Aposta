<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aposta - Agilita - Colecao 46</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        #login-container, #content-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            width: 100%;
            margin: 10px;
        }

        h1, h2 {
            text-align: center;
            color: #3a3a3a;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 8px;
            text-align: center;
        }

        #login-form input {
            display: block;
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            box-sizing: border-box;
        }

        #login-form button {
            width: 100%;
            padding: 10px;
            background-color: #28a745;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        #login-form button:hover {
            background-color: #218838;
            transform: scale(1.05);
        }

        #login-error {
            color: red;
            text-align: center;
            margin-top: 10px;
        }

        #consolidated-table {
            margin-top: 20px;
        }

        #download-button, #save-button, #back-button {
            margin-top: 20px;
            transition: all 0.3s ease;
        }

        #download-button, #save-button {
            display: none;
        }

        #back-button:hover, #save-button:hover, #consolidate-button:hover, #download-button:hover {
            transform: scale(1.05);
        }

        img {
            max-width: 100%;
            height: auto;
        }

        .pagination {
            text-align: center;
            margin-top: 20px;
        }

        .pagination button {
            padding: 8px 16px;
            margin: 5px;
            border: 1px solid #ddd;
            background-color: #fff;
            cursor: pointer;
        }

        .pagination button.active {
            background-color: #28a745;
            color: #fff;
        }

        .pagination button:hover {
            background-color: #218838;
            color: #fff;
        }

        #welcome-message {
            text-align: center;
            margin-bottom: 20px;
            color: #3a3a3a;
        }
    </style>
</head>
<body>
    <div id="login-container">
        <h2>Aposta - Agilita - Colecao 46</h2>
        <form id="login-form">
            <input type="text" id="username" placeholder="usuario" required>
            <input type="password" id="password" placeholder="Senha" required>
            <button type="submit">Entrar</button>
        </form>
        <div id="login-error"></div>
    </div>

    <div id="content-container" style="display: none;">
        <h1>Agilita - Colecao 46</h1>
        <div id="welcome-message"></div>
        <div id="table-container" style="display: none;">
            <!-- Tabela para usuários comuns -->
        </div>
        <button id="consolidate-button" style="display: none;">Consolidar</button>
        <button id="save-button" style="display: none;">Salvar</button>
        <button id="back-button">Voltar ao Login</button>
        <div id="consolidated-result"></div>
        <button id="download-button">Baixar Consolidação em Excel</button>
        <div class="pagination" id="pagination"></div>
    </div>

    <script>
        const users = {
            'admin': { password: 'admin123', role: 'admin' },
            'user1': { password: 'senha1', role: 'user', data: {} },
            'user2': { password: 'senha2', role: 'user', data: {} },
            'user3': { password: 'senha3', role: 'user', data: {} },
        };

        const items = [
            {
                imageUrl: 'https://agilita.vtexassets.com/arquivos/ids/602846-1600-auto?v=638562165963770000&width=1600&height=auto&aspect=true', 
                grupo: 'Grupo 1',
                descProduto: 'Produto 1',
                descCor: 'Cor 1'
            },
            {
                imageUrl: 'https://agilita.vtexassets.com/arquivos/ids/602847-1600-auto?v=638562165963770000&width=1600&height=auto&aspect=true', 
                grupo: 'Grupo 2',
                descProduto: 'Produto 2',
                descCor: 'Cor 2'
            },
            {
                imageUrl: 'https://agilita.vtexassets.com/arquivos/ids/602848-1600-auto?v=638562165963770000&width=1600&height=auto&aspect=true', 
                grupo: 'Grupo 3',
                descProduto: 'Produto 3',
                descCor: 'Cor 3'
            },
            {
                imageUrl: 'https://agilita.vtexassets.com/arquivos/ids/602849-1600-auto?v=638562165963770000&width=1600&height=auto&aspect=true', 
                grupo: 'Grupo 4',
                descProduto: 'Produto 4',
                descCor: 'Cor 4'
            }
        ];

        let currentUser;
        let responses = {};
        let currentPage = 1;
        const itemsPerPage = 2;

        document.getElementById('login-form').addEventListener('submit', function(event) {
            event.preventDefault();
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;

            if (users[username] && users[username].password === password) {
                currentUser = { username: username, role: users[username].role, data: users[username].data };
                document.getElementById('login-container').style.display = 'none';
                document.getElementById('content-container').style.display = 'block';
                document.getElementById('welcome-message').textContent = `Bem-vindo, ${username}!`;

                if (currentUser.role === 'user') {
                    displayPage(1);
                    document.getElementById('save-button').style.display = 'block';
                    document.getElementById('table-container').style.display = 'block';
                } else if (currentUser.role === 'admin') {
                    document.getElementById('consolidate-button').style.display = 'block';
                    document.getElementById('table-container').style.display = 'none';
                }
            } else {
                document.getElementById('login-error').textContent = 'usuario ou senha incorretos!';
            }
        });

        function displayPage(page) {
            currentPage = page;
            const startIndex = (page - 1) * itemsPerPage;
            const endIndex = startIndex + itemsPerPage;
            const visibleItems = items.slice(startIndex, endIndex);

            generateTable(visibleItems.length, visibleItems);
            updatePagination();
        }

        function generateTable(itemCount, itemsToShow) {
            const tableContainer = document.getElementById('table-container');
            let tableHTML = '<table id="classification-table"><tr><th>Foto</th><th>Grupo</th><th>Desc Produto</th><th>Desc Cor</th><th>Classificação</th></tr>';
            for (let i = 0; i < itemCount; i++) {
                const savedValue = currentUser.data[i] || '';
                const item = itemsToShow[i];

                tableHTML += `<tr>
                    <td><img src="${item.imageUrl}" alt="Item ${i + 1}"></td>
                    <td>${item.grupo}</td>
                    <td>${item.descProduto}</td>
                    <td>${item.descCor}</td>
                    <td><select data-item="${i}" data-user="${currentUser.username}">
                        <option value="A" ${savedValue === 'A' ? 'selected' : ''}>A</option>
                        <option value="B" ${savedValue === 'B' ? 'selected' : ''}>B</option>
                        <option value="C" ${savedValue === 'C' ? 'selected' : ''}>C</option>
                        <option value="D" ${savedValue === 'D' ? 'selected' : ''}>D</option>
                    </select></td>
                </tr>`;
            }

            tableHTML += '</table>';
            tableContainer.innerHTML = tableHTML;

            // Adiciona eventos de mudança para cada seleção de classificação
            document.querySelectorAll('select').forEach(select => {
                select.addEventListener('change', function() {
                    const item = this.getAttribute('data-item');
                    const user = this.getAttribute('data-user');
                    const value = this.value;

                    if (!responses[item]) {
                        responses[item] = {};
                    }
                    responses[item][user] = value;
                });
            });
        }

        // Função para atualizar a paginação no rodapé
        function updatePagination() {
            const paginationContainer = document.getElementById('pagination');
            const totalPages = Math.ceil(items.length / itemsPerPage);
            paginationContainer.innerHTML = '';

            for (let i = 1; i <= totalPages; i++) {
                const button = document.createElement('button');
                button.textContent = i;
                if (i === currentPage) {
                    button.classList.add('active');
                }

                button.addEventListener('click', () => displayPage(i));
                paginationContainer.appendChild(button);
            }
        }

        // Event listener para salvar dados
        document.getElementById('save-button').addEventListener('click', function() {
            document.querySelectorAll('select').forEach(select => {
                const item = select.getAttribute('data-item');
                const value = select.value;
                currentUser.data[item] = value;
            });

            users[currentUser.username].data = currentUser.data;
            alert('Dados salvos com sucesso!');
        });

        // Event listener para retornar ao login
        document.getElementById('back-button').addEventListener('click', function() {
            document.getElementById('content-container').style.display = 'none';
            document.getElementById('login-container').style.display = 'block';
            currentUser = null;
        });

        // Event listener para consolidação de dados
        document.getElementById('consolidate-button').addEventListener('click', function() {
            let consolidatedHTML = '<table id="consolidated-table"><tr><th>Item</th><th>Usuário</th><th>Classificação</th></tr>';

            for (const item in responses) {
                for (const user in responses[item]) {
                    consolidatedHTML += `<tr><td>Item ${parseInt(item) + 1}</td><td>${user}</td><td>${responses[item][user]}</td></tr>`;
                }
            }

            consolidatedHTML += '</table>';
            document.getElementById('consolidated-result').innerHTML = consolidatedHTML;

            document.getElementById('download-button').style.display = 'block';
        });

        // Event listener para download em CSV
        document.getElementById('download-button').addEventListener('click', function() {
            let csvContent = "data:text/csv;charset=utf-8,";
            csvContent += "Item,Usuário,Classificação\n";

            for (const item in responses) {
                for (const user in responses[item]) {
                    csvContent += `${parseInt(item) + 1},${user},${responses[item][user]}\n`;
                }
            }

            const encodedUri = encodeURI(csvContent);
            const link = document.createElement("a");
            link.setAttribute("href", encodedUri);
            link.setAttribute("download", "consolidated_results.csv");
            document.body.appendChild(link);

            link.click();
            document.body.removeChild(link);
        });

        // Função para exibir a página inicial ao carregar
        window.onload = function() {
            window.scrollTo(0, 0);
        };
    </script>
</body>
</html>
