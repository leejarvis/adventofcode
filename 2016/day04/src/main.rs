use std::collections::HashMap;

// Copilot basically generated 90% of this..

struct Room {
    name: String,
    sector_id: u32,
    checksum: String
}

impl Room {
    fn is_real(&self) -> bool {
        let mut counts = HashMap::new();
        for c in self.name.chars() {
            if c == '-' {
                continue;
            }
            let count = counts.entry(c).or_insert(0);
            *count += 1;
        }
        let mut counts = counts.into_iter().collect::<Vec<_>>();
        counts.sort_by(|a, b| {
            if a.1 == b.1 {
                a.0.cmp(&b.0)
            } else {
                b.1.cmp(&a.1)
            }
        });
        let checksum = counts.iter().take(5).map(|c| c.0).collect::<String>();
        checksum == self.checksum
    }

    fn decrypt(&self) -> String {
        let mut decrypted = String::new();
        for c in self.name.chars() {
            if c == '-' {
                decrypted.push(' ');
                continue;
            }
            let mut c = c as u8;
            for _ in 0..self.sector_id {
                c += 1;
                if c > 'z' as u8 {
                    c = 'a' as u8;
                }
            }
            decrypted.push(c as char);
        }
        decrypted
    }
}

fn parse_room(input: &'static str) -> Room {
    let mut parts = input.split(|c| c == '[' || c == ']');
    let mut name_parts = parts.next().unwrap().split("-").collect::<Vec<_>>();
    let sector_id = name_parts.pop().unwrap().parse().unwrap();
    let name = name_parts.join("-");
    let checksum = parts.next().unwrap().to_string();
    Room {
        name,
        sector_id,
        checksum,
    }
}

fn main() {
    let input = include_str!("../input.txt");

    let mut sum = 0;
    for line in input.lines() {
        let room = parse_room(line);
        if room.is_real() {
            sum += room.sector_id;
        }
    }

    println!("{}", sum);

    let mut north_pole_room = None;
    for line in input.lines() {
        let room = parse_room(line);
        if room.is_real() {
            let decrypted = room.decrypt();
            if decrypted.contains("north") {
                north_pole_room = Some(room);
                break;
            }
        }
    }

    println!("{:?}", north_pole_room.unwrap().sector_id);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_parse_room() {
        let input = "aaaaa-bbb-z-y-x-123[abxyz]";
        let room = parse_room(input);
        assert_eq!(room.name, "aaaaa-bbb-z-y-x");
        assert_eq!(room.sector_id, 123);
        assert_eq!(room.checksum, "abxyz");
    }

    #[test]
    fn test_room_is_real() {
        let input = "aaaaa-bbb-z-y-x-123[abxyz]";
        let room = parse_room(input);
        assert!(room.is_real());

        let input = "totally-real-room-200[decoy]";
        let room = parse_room(input);
        assert!(!room.is_real());
    }

    #[test]
    fn test_room_decrypt() {
        let input = "qzmt-zixmtkozy-ivhz-343[abxyz]";
        let room = parse_room(input);
        assert_eq!(room.decrypt(), "very encrypted name");
    }
}
