---
   unit: unidad didáctica 7
   title: Framework Laravel
   language: ES
   author: Arturo Blasco
   subject: Desarrollo Web en Entorno Servidor
   keywords: [DWES, 2023, PHP, Laravel]
   IES: IES Mestre Ramón Esteve (Catadau) [iesmre.es]
   header: ${unit}: ${title} - ${subject} (versión: ${today})
   footer: ${currentFileName}.pdf - ${author} - ${IES} - ${pageNo}|${pageCount}
   typora-root-url:${filename}/../
   typora-copy-images-to:${filename}/../assets

---



# creación de un carrito de compras en laravel fácil y rápido

Creado por Enrique Martínez para el canal de youtube [compucenter33](https://www.youtube.com/c/compucenter33)

<img src="https://lh7-us.googleusercontent.com/_Yx_03ZdyMxy06TzR8AcVvqohz-174YeZpk7bTVHM4fTrnIS3bfGSiW8bZi4Ay87D7zn5B77cLEnOA6aGhbnCIlMBRq6aYZgOffnrYlq1w6ySDiwKF4silRPZauYrZ4vFlZgBqBMozo9rKUGpR6j9s0" alt="img" style="zoom: 45%;" />

Para que este ejercicio sea rápido y fácil usaremos un plugin llamado [**darryldecode/cart**](https://github.com/darryldecode/laravelshoppingcart)

https://github.com/darryldecode/laravelshoppingcart



1. Comenzamos rápidamente descargando laravel:

   ```php
   composer create-project --prefer-dist laravel/laravel carrito
   ```

2. Configuramos la base de datos en el archivo **.env** y creamos la base de datos en phpmyadmin como indica el video

   configurar el **.env** -> el nombre de la base de datos puede ser **carrito**

3. Instalamos el plugin anteriormente mencionado desde la terminal de visual code:

   ```php
   sudo docker-compose exec myapp composer require "darryldecode/cart"
   ```

4. Editamos el archivo `config/app.php` y en el array **Providers** agregamos:

   ```php
   //..
   Darryldecode\Cart\CartServiceProvider::class,
   //..
   ```

   Luego en el array **Aliases** agregamos:

   ```php
   //...
   'Cart' => Darryldecode\Cart\Facades\CartFacade::class,
   //...
   ```

5. Crea el Modelo **Product** y su archivo de migración en la terminal de visual studio code:

   ```sh
   php artisan make:model Product -m
   # ó, si no funciona:
   # sudo docker-compose exec myapp php artisan make:model Product -m
   ```

6. Agrega los campos para nuestra migración products en `database/migrations` algo como `2024_01_12_102939_create_products_table.php`:

   ```php
   Schema::create('products', function (Blueprint $table) {
       $table->id();
       $table->string('name')->unique();
       $table->string('slug')->unique();
       $table->string('details')->nullable();
       $table->double('price');
       $table->double('shipping_cost');
       $table->text('description');
       $table->integer('category_id');
       $table->unsignedInteger('brand_id')->unsigned();
       $table->string('image_path');
       $table->timestamps();
   });
   ```

7. Alimentar datos a la base de datos Ahora podemos introducir algunos datos en la tabla que hemos creado. Laravel proporciona Sembradoras "seeders" para eso, en la terminal y escribe este comando:

   ```sh
   php artisan make:seed ProductsTableSeeder
   # ó, si no funciona:
   # sudo docker-compose exec myapp php artisan make:seed ProductsTableSeeder
   ```

8. Ahora modifica el archivo de Seeder que está en `database\seeders\ProductsTableSeeder.php` (en la cabecera importar Product y dentro de `public function run():void{..}`):

   ```php
   use App\Models\Product;
   use Illuminate\Support\Facades\DB;
   //...
       DB::table('products')->insert([
           'name' => 'MacBook Pro',
           'slug' => 'macbook-pro',
           'details' => '15 pulgadas, 1TB HDD, 32GB RAM',
           'price' => 2499.99,
           'shipping_cost' => 29.99,
           'description' => 'MackBook Pro',
           'category_id' => 1,
           'brand_id' => 1,
           'image_path' => 'macbook-pro.png'
       ]);
   
       DB::table('products')->insert([
           'name' => 'Dell Vostro 3557',
           'slug' => 'vostro-3557',
           'details' => '15 pulgadas, 1TB HDD, 8GB RAM',
           'price' => 1499.99,
           'shipping_cost' => 19.99,
           'description' => 'Dell Vostro 3557',
           'category_id' => 1,
           'brand_id' => 2,
           'image_path' => 'dell-v3557.png'
       ]);
   
       DB::table('products')->insert([
           'name' => 'iPhone 11 Pro',
           'slug' => 'iphone-11-pro',
           'details' => '6.1 pulgadas, 64GB 4GB RAM',
           'price' => 649.99,
           'shipping_cost' => 14.99,
           'description' => 'iPhone 11 Pro',
           'category_id' => 2,
           'brand_id' => 1,
           'image_path' => 'iphone-11-pro.png'
       ]);
   
       DB::table('products')->insert([
           'name' => 'Remax 610D Headset',
           'slug' => 'remax-610d',
           'details' => '6.1 pulgadas, 64GB 4GB RAM',
           'price' => 8.99,
           'shipping_cost' => 1.89,
           'description' => 'Remax 610D Headset',
           'category_id' => 3,
           'brand_id' => 3,
           'image_path' => 'remax-610d.jpg'
       ]);
   
       DB::table('products')->insert([
           'name' => 'Samsung LED TV',
           'slug' => 'samsung-led-24',
           'details' => '24 pulgadas, LED Display, Resolución 1366 x 768',
           'price' => 41.99,
           'shipping_cost' => 12.59,
           'description' => 'Samsung LED TV',
           'category_id' => 4,
           'brand_id' => 4,
           'image_path' => 'samsung-led-24.png'
       ]);
   
       DB::table('products')->insert([
           'name' => 'Samsung Camara Digital',
           'slug' => 'samsung-mv800',
           'details' => '16.1MP, 5x Optical Zoom',
           'price' => 144.99,
           'shipping_cost' => 13.39,
           'description' => 'Samsung Digital Camera',
           'category_id' => 5,
           'brand_id' => 4,
           'image_path' => 'samsung-mv800.jpg'
       ]);
   
       DB::table('products')->insert([
           'name' => 'Huawei GR 5 2017',
           'slug' => 'gr5-2017',
           'details' => '5.5 pulgadas, 32GB 4GB RAM',
           'price' => 148.99,
           'shipping_cost' => 6.79,
           'description' => 'Huawei GR 5 2017',
           'category_id' => 2,
           'brand_id' => 5,
           'image_path' => 'gr5-2017.jpg'
       ]);
   //...
   ```

9. Ahora editamos el archivo `database/seeders/DatabaseSeeder.php` y le agregamos la clase:

   ```php
   $this->call(ProductsTableSeeder::class);
   ```

10. Ahora crearemos las tablas de la BD y los productos de prueba:

    ```sh
    php artisan migrate
    # ó, si no funciona:
    # sudo docker-compose exec myapp php artisan migrate
    ```

11. Ejecutar el seeder:

    ```php
    php artisan db:seed --class=ProductsTableSeeder
    # ó, si no funciona:
    # sudo docker-compose exec myapp php artisan db:seed --class=ProductsTableSeeder
    ```

12. Crea un controlador para el carrito:

    ```sh
    php artisan make:controller CartController
    # ó, si no funciona:
    # sudo docker-compose exec myapp php artisan make:controller CartController
    ```

13. editamos el archivo `CartController.php` y le pegamos este código:

    ```php
    namespace App\Http\Controllers;
    
    use Illuminate\Http\Request;
    use App\Models\Product;
    
    class CartController extends Controller
    {
    
      public function shop() {
        $products = Product::all();
        dd($products);
        return view('shop')->withTitle('E-COMMERCE STORE | SHOP')->with(['products' => $products]);
      }
    
      public function cart() {
    	$cartCollection = \Cart::getContent();
    	//dd($cartCollection);
    	return view('cart')->withTitle('E-COMMERCE STORE | CART')->with(['cartCollection' => $cartCollection]);;
      }
    
      public function remove(Request $request){
    	\Cart::remove($request->id);
    	return redirect()->route('cart.index')->with('success_msg', 'Item is removed!');
      }
    
      public function add(Request$request){
            \Cart::add(array(
            'id' => $request->id,
            'name' => $request->name,
            'price' => $request->price,
            'quantity' => $request->quantity,
            'attributes' => array(
            'image' => $request->img,
            'slug' => $request->slug
            )
        ));
        return redirect()->route('cart.index')->with('success_msg', 'Item Agregado a sú Carrito!');
      }
    
      public function update(Request $request){
    	\Cart::update($request->id,
    	array(
    		'quantity' => array(
    		'relative' => false,
    		'value' => $request->quantity
    	),
    
        ));
        return redirect()->route('cart.index')->with('success_msg', 'Cart is Updated!');
      }
    
      public function clear(){
    	\Cart::clear();
    	return redirect()->route('cart.index')->with('success_msg', 'Car is cleared!');
      }
    
    }
    ```

14. Creamos las rutas en `web.php`:

    ```php
    //...
    use App\Http\Controllers\CartController;
    //...
    Route::get('/', [CartController::class, 'shop'])->name('shop');
    Route::get('/cart', [CartController::class, 'cart'])->name('cart.index');
    Route::post('/add', [CartController::class, 'add'])->name('cart.store');
    Route::post('/update', [CartController::class, 'update'])->name('cart.update');
    Route::post('/remove', [CartController::class, 'remove'])->name('cart.remove');
    Route::post('/clear', [CartController::class, 'clear'])->name('cart.clear');
    ```

15. Ejecutemos el servidor virtual para probar nuestro proyecto en la terminal:

    ```php
    php artisan serve
    # ó, si no funciona:
    # sudo docker-compose exec myapp php artisan serve
    ```

16. Crear vistas Ahora tenemos que crear dos vistas tanto para el carrito como para las páginas de la tienda en la carpeta `resources/views` Nombramos nuestras dos vistas como `cart.blade.php` y `shop.blade.php`. Así tal cuál.

    Editamos el archivo `resources\views\shop.blade.php` y pegamos el siguiente código:

    ```php+HTML
    @extends('layouts.app')
    
    @section('content')
    <div class="container" style="margin-top: 80px">
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/">Inicio</a></li>
            <li class="breadcrumb-item active" aria-current="page">Tienda</li>
          </ol>
        </nav>
        <div class="row justify-content-center">
          <div class="col-lg-12">
            <div class="row">
              <div class="col-lg-7">
                <h4>Productos</h4>
              </div>
            </div>
            <hr>
            <div class="row">
              @foreach($products as $pro)
                <div class="col-lg-3">
                    <div class="card" style="margin-bottom: 20px; height: auto;">
                      <img src="/images/{{ $pro->image_path }}"
                           class="card-img-top mx-auto"
                           style="height: 150px; width: 150px;display: block;"
                           alt="{{ $pro->image_path }}"
                      >
                      <div class="card-body">
                        <a href=""><h6 class="card-title">{{ $pro->name }}</h6></a>
                        <p>${{ $pro->price }}</p>
                        <form action="{{ route('cart.store') }}" method="POST">
                          {{ csrf_field() }}
                          <input type="hidden" value="{{ $pro->id }}" id="id" name="id">
                          <input type="hidden" value="{{ $pro->name }}" id="name" name="name">
                          <input type="hidden" value="{{ $pro->price }}" id="price" name="price">
                          <input type="hidden" value="{{ $pro->image_path }}" id="img" name="img">
                          <input type="hidden" value="{{ $pro->slug }}" id="slug" name="slug">
                          <input type="hidden" value="1" id="quantity" name="quantity">
                          <div class="card-footer" style="background-color: white;">
                            <div class="row">
                              <button class="btn btn-secondary btn-sm" class="tooltip-test" title="add to cart">
                                <i class="fa fa-shopping-cart"></i> agregar al carrito
                              </button>
                            </div>
                          </div>
                        </form>
                      </div>
                    </div>
                  </div>
                @endforeach
            </div>
          </div>
        </div>
    </div>
    @endsection
    
    ```

    

























