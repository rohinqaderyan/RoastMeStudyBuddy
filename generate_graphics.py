#!/usr/bin/env python3
"""
Generate decorative graphics for HomeView
"""

from PIL import Image, ImageDraw
import os
import math

def create_hero_illustration(size=800):
    """Create a hero illustration with fire, books, and brain theme"""
    img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    center_x = size // 2
    
    # Draw stylized flame character (mascot)
    flame_y = int(size * 0.35)
    
    # Main flame body (cute character style)
    flame_points = [
        (center_x, int(size * 0.65)),  # Bottom
        (int(size * 0.30), int(size * 0.40)),
        (int(size * 0.35), int(size * 0.25)),
        (center_x, int(size * 0.15)),  # Top
        (int(size * 0.65), int(size * 0.25)),
        (int(size * 0.70), int(size * 0.40)),
    ]
    
    # Outer glow
    for offset in range(20, 0, -2):
        glow_points = [(x + (offset if i % 2 == 0 else -offset) // 2, y) for i, (x, y) in enumerate(flame_points)]
        alpha = int(30 * (offset / 20))
        draw.polygon(glow_points, fill=(255, 140, 0, alpha))
    
    draw.polygon(flame_points, fill=(255, 87, 34))
    
    # Inner flame layers
    inner_points = [
        (center_x, int(size * 0.60)),
        (int(size * 0.38), int(size * 0.42)),
        (center_x, int(size * 0.23)),
        (int(size * 0.62), int(size * 0.42)),
    ]
    draw.polygon(inner_points, fill=(255, 152, 0))
    
    core_points = [
        (center_x, int(size * 0.55)),
        (int(size * 0.43), int(size * 0.45)),
        (center_x, int(size * 0.30)),
        (int(size * 0.57), int(size * 0.45)),
    ]
    draw.polygon(core_points, fill=(255, 235, 59))
    
    # Eyes (cute character)
    eye_y = int(size * 0.42)
    eye_left_x = int(size * 0.42)
    eye_right_x = int(size * 0.58)
    eye_size = int(size * 0.04)
    
    # Eye whites
    draw.ellipse([eye_left_x - eye_size, eye_y - eye_size, eye_left_x + eye_size, eye_y + eye_size], 
                 fill=(255, 255, 255))
    draw.ellipse([eye_right_x - eye_size, eye_y - eye_size, eye_right_x + eye_size, eye_y + eye_size], 
                 fill=(255, 255, 255))
    
    # Pupils
    pupil_size = int(eye_size * 0.6)
    draw.ellipse([eye_left_x - pupil_size, eye_y - pupil_size, eye_left_x + pupil_size, eye_y + pupil_size], 
                 fill=(50, 50, 50))
    draw.ellipse([eye_right_x - pupil_size, eye_y - pupil_size, eye_right_x + pupil_size, eye_y + pupil_size], 
                 fill=(50, 50, 50))
    
    # Smile (determined expression)
    smile_y = int(size * 0.50)
    draw.arc([int(size * 0.40), smile_y - 15, int(size * 0.60), smile_y + 15], 
             0, 180, fill=(50, 50, 50), width=4)
    
    # Books at bottom
    book_y = int(size * 0.72)
    for i, (offset, color) in enumerate([(-80, (103, 58, 183)), (0, (156, 39, 176)), (80, (233, 30, 99))]):
        book_x = center_x + offset
        draw.rounded_rectangle(
            [book_x - 40, book_y, book_x + 40, book_y + 60],
            radius=6,
            fill=color
        )
        # Book spine
        draw.line([(book_x, book_y), (book_x, book_y + 60)], fill=(255, 255, 255, 150), width=2)
    
    return img

def create_floating_element(element_type, size=200):
    """Create floating decorative elements"""
    img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    center = size // 2
    
    if element_type == "star":
        # Draw star
        points = []
        for i in range(10):
            angle = (i * 36 - 90) * math.pi / 180
            radius = (size * 0.4) if i % 2 == 0 else (size * 0.2)
            x = center + int(radius * math.cos(angle))
            y = center + int(radius * math.sin(angle))
            points.append((x, y))
        draw.polygon(points, fill=(255, 235, 59, 200))
        
    elif element_type == "sparkle":
        # Draw sparkle
        for angle in [0, 45, 90, 135]:
            rad = angle * math.pi / 180
            length = size * 0.4
            x1 = center + int(length * 0.3 * math.cos(rad))
            y1 = center + int(length * 0.3 * math.sin(rad))
            x2 = center + int(length * math.cos(rad))
            y2 = center + int(length * math.sin(rad))
            draw.line([(x1, y1), (x2, y2)], fill=(255, 255, 255, 220), width=int(size * 0.08))
            
    elif element_type == "flame_small":
        # Small flame
        points = [
            (center, int(size * 0.8)),
            (int(size * 0.3), center),
            (center, int(size * 0.2)),
            (int(size * 0.7), center),
        ]
        draw.polygon(points, fill=(255, 152, 0, 200))
        
    return img

def create_gradient_orb(size=400, color_center=(255, 193, 7), color_edge=(255, 87, 34)):
    """Create a glowing gradient orb"""
    img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    center = size // 2
    max_radius = size // 2
    
    for i in range(max_radius, 0, -2):
        ratio = i / max_radius
        r = int(color_edge[0] * ratio + color_center[0] * (1 - ratio))
        g = int(color_edge[1] * ratio + color_center[1] * (1 - ratio))
        b = int(color_edge[2] * ratio + color_center[2] * (1 - ratio))
        alpha = int(150 * (1 - ratio * 0.5))
        
        bbox = [center - i, center - i, center + i, center + i]
        draw.ellipse(bbox, fill=(r, g, b, alpha))
    
    return img

def main():
    base_path = "/Users/QADERA01/iOS App/RoastMeStudyBuddy/RoastMeStudyBuddy/Assets.xcassets"
    
    # Create ImageSet folders
    assets = {
        "HeroIllustration": create_hero_illustration(800),
        "GradientOrb": create_gradient_orb(400),
        "StarDecor": create_floating_element("star", 150),
        "SparkleDecor": create_floating_element("sparkle", 150),
        "FlameDecor": create_floating_element("flame_small", 120),
    }
    
    for name, img in assets.items():
        folder_path = os.path.join(base_path, f"{name}.imageset")
        os.makedirs(folder_path, exist_ok=True)
        
        # Save image
        img_path = os.path.join(folder_path, f"{name}.png")
        img.save(img_path, 'PNG')
        
        # Create Contents.json
        contents = {
            "images": [
                {
                    "filename": f"{name}.png",
                    "idiom": "universal"
                }
            ],
            "info": {
                "author": "xcode",
                "version": 1
            }
        }
        
        import json
        with open(os.path.join(folder_path, "Contents.json"), 'w') as f:
            json.dump(contents, f, indent=2)
        
        print(f"✅ Created: {name}")
    
    print("\n🎨 All decorative graphics created successfully!")

if __name__ == "__main__":
    main()
